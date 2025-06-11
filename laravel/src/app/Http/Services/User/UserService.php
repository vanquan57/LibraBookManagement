<?php

namespace App\Http\Services\User;

use App\Http\Repositories\EmployeeCodeRepositoryInterface;
use App\Http\Repositories\UserRepositoryInterface;
use App\Models\User;
use Illuminate\Auth\Events\Verified;
use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\EmailVerificationRequest;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Log;
use Laravel\Socialite\Facades\Socialite;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Password;
use Illuminate\Auth\Events\PasswordReset;
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class UserService
{
    /**
     * Constructor
     *
     * @param UserRepositoryInterface $userRepository
     * 
     * @param EmployeeCodeRepositoryInterface $employeeCodeRepository
     *
     * @return void
     */
    public function __construct(
        protected UserRepositoryInterface $userRepository,
        protected EmployeeCodeRepositoryInterface $employeeCodeRepository,
    ) {}


    /**
     * Register a newly created resource in storage.
     *
     * @param array $data
     *
     * @return array
     */
    public function register(array $data): array
    {
        DB::beginTransaction();
        
        try {
            if ($user = $this->userRepository->getRegisteredAccount($data['code'], $data['email'])) {
                if(!empty($user->google_id) && empty($user->password)) {
                    if(!$this->userRepository->updateInfoWhenMappingAccountGoogle($user, $data)) {
                        throw new \Exception('Có lỗi xảy ra vui lòng thử lại sau.', Response::HTTP_INTERNAL_SERVER_ERROR);
                    }

                    DB::commit();

                    return [
                        'message' => 'Đăng ký tài khoản thành công',
                        'code' => Response::HTTP_CREATED,
                    ];
                }else{
                    throw new \Exception('Tài khoản đã được đăng ký', Response::HTTP_BAD_REQUEST);
                }
            }

            // Using for unique email and code not using form request because has method register with google account
            if($this->userRepository->checkExistsAccountRegister($data['code'], $data['email'])) {
                throw new \Exception('Tài khoản đã được đăng ký', Response::HTTP_BAD_REQUEST);
            }

            if ($this->employeeCodeRepository->checkIsEmployeeKiaisoft($data['code'], $data['email'])) {
                $data['status'] = User::STATUS_ACTIVE;
            }

            if($user = $this->userRepository->store($data)) {
                event(new Registered($user));
                
                DB::commit();

                return [
                    'message' => 'Đăng ký tài khoản thành công. Vui lòng kiểm tra email để xác thực tài khoản',
                    'code' => Response::HTTP_CREATED,
                ];
            }
        } catch (\Exception $e) {
            Log::error($e->getMessage());
            DB::rollBack();

            return [
                'error' => $e->getMessage(),
                'error_code' => match ($e->getCode()) {
                        Response::HTTP_BAD_REQUEST => ERROR_BAD_REQUEST,
                        default => ERROR_CODE_INTERNAL_SERVER_ERROR
                },
                'code' => $e->getCode() ?? ERROR_CODE_INTERNAL_SERVER_ERROR,
            ];
        }
    }

    /**
     * The method verification email.
     * 
     *  @param Request $request
     * 
     * @return array
     */
    public function verifyEmail(Request $request): array
    {
        try {
            $user = $this->userRepository->find($request->route('id'));

            if (!$user) {
                throw new \Exception('Tài khoản không tồn tại', Response::HTTP_NOT_FOUND);
            }

            if (!$user->hasVerifiedEmail() && $user->markEmailAsVerified()) {
                event(new Verified($user));

                return [
                    'message' => 'Xác thực email thành công',
                    'code' => Response::HTTP_OK
                ];
            }

            throw new \Exception('Xác thực email không thành công', Response::HTTP_BAD_REQUEST);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return [
                'error' => $e->getMessage(),
                'error_code' => match ($e->getCode()) {
                    Response::HTTP_BAD_REQUEST => ERROR_BAD_REQUEST,
                    default => ERROR_CODE_INTERNAL_SERVER_ERROR
                },
                'code' => $e->getCode() ?? ERROR_CODE_INTERNAL_SERVER_ERROR,
            ];
        }
    }

    /**
     * Find the user with google id
     *
     * @param string $googleId
     *
     * @return Authenticatable|null
     */
    public function findByGoogleId(string $googleId): ?Authenticatable
    {
        try {
            return $this->userRepository->findByGoogleId($googleId);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * The method register new google account
     *
     * @param array $data
     *
     * @return Authenticatable|null
     */
    public function registerGoogle(array $data): ?Authenticatable
    {
        try {
            $userGoogle = Socialite::driver('google')->userFromToken($data['access_token']);

            if (!$userGoogle) {
                return null;
            }

            $userRegistered = $this->userRepository->getRegisteredAccount($data['code'], $userGoogle->user['email']);

            // Check if the user has registered an account but not mapping with google id
            if ($userRegistered && empty($userRegistered->google_id)) {
                if(!$this->userRepository->updateInfoWhenMappingAccountEmailPassword($userRegistered, $userGoogle->user['sub'])){
                    return null;
                }

                return $userRegistered;
            }

            // Check if the user has not registered an account
            if (!$userRegistered) {
                if (!$this->employeeCodeRepository->checkIsEmployeeKiaisoft($data['code'], $userGoogle->user['email'])) {
                    return null;
                }

                if (strpos($userGoogle->user['email'], config('constants.FORMAT_EMAIL_EMPLOYEE')) === false) {
                    return null;
                }

                $user = $this->userRepository->registerGoogle($data['code'], $userGoogle);

                if ($user && $user->markEmailAsVerified()) {
                    return $user;
                }
            }

            // Check if user registered with google account and mapping with google id
            if($userRegistered && $userRegistered->google_id == $userGoogle->user['sub']) {
                return $userRegistered;
            }

            return null;
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * The create token request and send to email address
     *
     * @param array $data
     *
     * @return bool
     */
    public function sendEmail(array $data): bool
    {
        try {
            $user = $this->userRepository->findByEmail($data['email']);

            if (!$user) {
                return false;
            }

            $status = Password::sendResetLink([
                'email' => $data['email']
            ]);

            if ($status === Password::ResetLinkSent) {
                return true;
            }
            
            return false;
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return false;
        }
    }

    /**
     * The method reset password
     *
     * @param array $data
     *
     * @return array
     */
    public function resetPassword(array $data): array
    {
        try {
            $status = Password::reset([
                'email' => $data['email'],
                'token' => $data['token'],
                'password' => $data['password'],
            ], function (User $user, string $password) {
                $user->forceFill([
                    'password' => Hash::make($password)
                ])->setRememberToken(Str::random(60));
     
                if(!$this->userRepository->commitChanges($user)){
                    throw new \Exception('Có lỗi xảy ra vui lòng thử lại sau.', Response::HTTP_INTERNAL_SERVER_ERROR);
                }
     
                event(new PasswordReset($user));
            });

            if ($status === Password::InvalidUser) {
                throw new \Exception('Không tìm thấy tài khoản của bạn.', Response::HTTP_NOT_FOUND);
            }

            if ($status === Password::InvalidToken){
                throw new \Exception('Token không đúng hoặc đã hết hạn vui lòng kiểm tra lại.', Response::HTTP_BAD_REQUEST);
            }

            if ($status === Password::PasswordReset) {
                return [
                    'message' => 'Đặt lại mật khẩu thành công',
                    'code' => Response::HTTP_OK,
                ];
            }
            
            throw new \Exception('Có lỗi xảy ra vui lòng thử lại sau', Response::HTTP_INTERNAL_SERVER_ERROR);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return [
                'error' => $e->getMessage(),
                'error_code' => match ($e->getCode()) {
                        Response::HTTP_BAD_REQUEST => ERROR_BAD_REQUEST,
                        Response::HTTP_NOT_FOUND => ERROR_CODE_NOT_FOUND,
                        default => ERROR_CODE_INTERNAL_SERVER_ERROR
                },
                'code' => $e->getCode(),
            ];
        }
    }

    /**
     * The change password
     * 
     * @param array $data
     * 
     * @return array
     */
    public function changePassword(array $data): array
    {
        try {
            $user = auth('api')->user();
            
            if (!Hash::check($data['current_password'], $user->password)) {
                throw new \Exception('Mật khẩu hiện tại không chính xác', Response::HTTP_BAD_REQUEST);
            }

            if(!$this->userRepository->updatePassword($user->id, $data['password'])) {
                throw new \Exception('Có lỗi xảy ra, vui lòng thử lại sau.', Response::HTTP_INTERNAL_SERVER_ERROR);
            }

            return [
                'message' => 'Đổi mật khẩu thành công',
                'code' => Response::HTTP_OK,
            ];
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return [
                'error' => $e->getMessage(),
                'error_code' => match ($e->getCode()) {
                        Response::HTTP_BAD_REQUEST => ERROR_BAD_REQUEST,
                        Response::HTTP_UNAUTHORIZED => ERROR_CODE_AUTHENTICATE,
                        default => ERROR_CODE_INTERNAL_SERVER_ERROR
                },
                'code' => $e->getCode(),
            ];
        }
    }

    /**
     * Show details information of user
     *
     * @param int $id
     *
     * @return Model|null
     */
    public function show(int $id): ?Model
    {
        try {
            return $this->userRepository->showDetails($id);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * The method update information user
     *
     * @param array $data
     *
     * @return bool
     */
    public function update(array $data, int $id): bool
    {
        try {
            return $this->userRepository->updateInformation($id, $data);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return false;
        }
    }
}
