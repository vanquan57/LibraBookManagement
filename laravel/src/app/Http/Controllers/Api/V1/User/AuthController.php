<?php

namespace App\Http\Controllers\Api\V1\User;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Http\Requests\User\ChangePasswordRequest;
use App\Http\Requests\User\EmailRequest;
use App\Http\Requests\User\RegisterGoogleRequest;
use App\Http\Requests\User\RegisterRequest;
use App\Http\Requests\User\ResetPasswordRequest;
use App\Http\Services\User\UserService;
use App\Models\User;
use Google_Client;
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Log;
use Laravel\Socialite\Facades\Socialite;

class AuthController extends Controller
{
    /**
     * Create a new AuthController instance.
     *
     * @param UserService $userService
     *
     * @return void
     */
    public function __construct(
        protected UserService $userService
    ) {}

    /**
     * Get a JWT via given credentials.
     *
     * @param LoginRequest $request
     *
     * @return JsonResponse
     */
    public function login(LoginRequest $request): JsonResponse
    {
        $credentials = $request->only('email', 'password');
        $credentials['role'] = User::ROLE_USER;
        $credentials['status'] = User::STATUS_ACTIVE;

        if (!$token = auth('api')->attempt($credentials)) {
            return responseErrorAPI(
                Response::HTTP_UNAUTHORIZED,
                ERROR_CODE_AUTHENTICATE,
                'Email hoặc mật khẩu không chính xác'
            );
        }

        $user = auth('api')->user();

        if (!$user->hasVerifiedEmail()) {
            event(new Registered($user));

            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Tài khoản của bạn chưa được xác thực email. Vui lòng kiểm tra email của bạn.'
            );
        }

        return responseOkAPI($this->respondWithToken($token));
    }

    /**
     * register a newly created resource in storage.
     *
     * @param RegisterRequest $request
     *
     * @return JsonResponse
     */
    public function register(RegisterRequest $request): JsonResponse
    {
        $result = $this->userService->register($request->validated());

        if ($result['code'] !== Response::HTTP_CREATED) {
            return responseErrorAPI(
                $result['code'],
                $result['error_code'],
                $result['error']
            );
        }

        return responseOkAPI(
            [
                'message' => $result['message']
            ],
            $result['code']
        );
    }

    /**
     * The method verification email.
     * 
     *  @param Request $request
     * 
     * @return JsonResponse
    */
    public function verifyEmail(Request $request)
    {
        $result = $this->userService->verifyEmail($request);

        if ($result['code'] !== Response::HTTP_OK) {
            return responseErrorAPI(
                $result['code'],
                $result['error_code'],
                $result['error']
            );
        }

        return responseOkAPI(
            [
                'message' => $result['message']
            ]
        );
    }

    /**
     * Function and register for google.
     *
     * @param RegisterGoogleRequest $request
     *
     * @return JsonResponse
     */
    public function registerGoogle(RegisterGoogleRequest $request): JsonResponse
    {
        if ($user = $this->userService->registerGoogle($request->validated())) {
            if (!$token = auth('api')->login($user)) {
                return responseErrorAPI(
                    Response::HTTP_UNAUTHORIZED,
                    ERROR_CODE_AUTHENTICATE,
                    'Bạn không có quyền truy cập vào trang web này'
                );
            }

            return responseOkAPI($this->respondWithToken($token));
        }

        return responseErrorAPI(
            Response::HTTP_BAD_REQUEST,
            ERROR_BAD_REQUEST,
            'Bạn không phải sinh viên VKU ?. Vui lòng kiểm tra email và mã sinh viên'
        );
    }

    /**
     * The method login google
     *
     * @param Request $request
     *
     * @return JsonResponse
     */
    public function loginGoogle(Request $request): JsonResponse
    {
        try {
            $userGoogle = Socialite::driver('google')->userFromToken($request->input('access_token'));

            if (!$userGoogle) {
                throw new \Exception('Không tìm thấy thông tin tài khoản. Vui lòng thử lại', Response::HTTP_UNAUTHORIZED);
            }

            $user = $this->userService->findByGoogleId($userGoogle->user['sub']);

            if (!$user) {
                throw new \Exception('Vui lòng đăng ký tài khoản trước khi đăng nhập.', Response::HTTP_UNAUTHORIZED);
            }

            if (!$token = auth('api')->login($user)) {
                throw new \Exception('Bạn không có quyền truy cập vào trang web này.', Response::HTTP_UNAUTHORIZED);
            }

            return responseOkAPI($this->respondWithToken($token));
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return responseErrorAPI(
                $e->getCode(),
                match ($e->getCode()) {
                    Response::HTTP_UNAUTHORIZED => ERROR_CODE_AUTHENTICATE,
                    default => ERROR_CODE_INTERNAL_SERVER_ERROR
                },
                $e->getMessage()
            );
        }
    }

    /**
     * Log the user out (Invalidate the token).
     *
     * @return JsonResponse
     */
    public function logout(): JsonResponse
    {
        auth('api')->logout();
        auth('api')->invalidate(auth('api')->getToken());

        return responseOkAPI([
            'message' => 'Đăng xuất thành công.'
        ]);
    }

    /**
     * Reset password send email notification with token.
     *
     * @param EmailRequest $request
     *
     * @return JsonResponse
     */
    public function sendEmail(EmailRequest $request): JsonResponse
    {
        if (!$this->userService->sendEmail($request->validated())) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau'
            );
        }

        return responseOkAPI([
            'message' => 'Gửi email thành công, vui lòng kiểm tra email của bạn.'
        ]);
    }

    /**
     * Reset password with token.
     *
     * @param ResetPasswordRequest $request
     *
     * @return JsonResponse
     */
    public function resetPassword(ResetPasswordRequest $request): JsonResponse
    {
        $result = $this->userService->resetPassword($request->validated());

        if ($result['code'] !== Response::HTTP_OK) {
            return responseErrorAPI(
                $result['code'],
                $result['error_code'],
                $result['error']
            );
        }

        return responseOkAPI(
            [
                'message' => $result['message']
            ]
        );
    }

    /**
     * Change password.
     *
     * @param ChangePasswordRequest $request
     *
     * @return JsonResponse
     */
    public function changePassword(ChangePasswordRequest $request): JsonResponse
    {
        $result = $this->userService->changePassword($request->validated());

        if ($result['code'] !== Response::HTTP_OK) {
            return responseErrorAPI(
                $result['code'],
                $result['error_code'],
                $result['error']
            );
        }

        return responseOkAPI(
            [
                'message' => $result['message']
            ]
        );
    }

    /**
     * Get the token array structure.
     *
     * @param string $token
     *
     * @return array
     */
    protected function respondWithToken($token): array
    {
        return [
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth('api')->factory()->getTTL() * 60,
        ];
    }
}
