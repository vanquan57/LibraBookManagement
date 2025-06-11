<?php

namespace App\Http\Services;

use App\Http\Repositories\EmployeeCodeRepositoryInterface;
use App\Http\Repositories\UserRepositoryInterface;
use App\Models\User;
use Illuminate\Http\Response;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class UserService
{
    /**
     * Constructor
     *
     * @param UserRepositoryInterface $userRepository
     *
     * @return void
     */
    public function __construct(
        protected UserRepositoryInterface $userRepository,
        protected EmployeeCodeRepositoryInterface $employeeCodeRepository
    ) {}

    /**
     * Public function get all users
     *
     * @param array $dataSearch
     *
     * @return LengthAwarePaginator|null
     */
    public function getAllByPagination(array $dataSearch): ?LengthAwarePaginator
    {
        try {
            $data = [
                'key_word' => $dataSearch['key_word'] ?? null,
                'limit' => $dataSearch['limit'] ?? config('constants.DEFAULT_LIMIT'),
                'column' => $dataSearch['column'] ?? null,
                'order' => $dataSearch['type'] ?? null,
                'status' => $dataSearch['status'] ?? null,
            ];

            return $this->userRepository->getAllByPagination($data);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * Public function update user
     *
     * @param array $data
     * 
     * @param int $id
     *
     * @return bool
     */
    public function updateStatus(array $data, int $id): bool
    {
        try {
            $user = $this->userRepository->find($id);

            if (!$user) {
                return false;
            }

            if ($user->status === $data['status']) {
                return false;
            }

            if ($data['status'] === User::STATUS_BLOCK) {
                return $this->userRepository->update($id, $data);
            }

            switch ($user->status) {
                case User::STATUS_WAITING:
                    if (
                        $data['status'] === User::STATUS_ACTIVE &&
                        $this->employeeCodeRepository->checkIsEmployeeKiaisoft($user->code, $user->email)
                    ) {
                        return $this->userRepository->update($id, $data);
                    }
                    break;

                case User::STATUS_ACTIVE:
                    if ($data['status'] === User::STATUS_WAITING) {
                        return $this->userRepository->update($id, $data);
                    }
                    break;

                case User::STATUS_BLOCK:
                    if ($data['status'] === User::STATUS_WAITING) {
                        return $this->userRepository->update($id, $data);
                    }
                    break;

                default:
                    return false;
            }

            return false;
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return false;
        }
    }

    /**
     * Public function get all employees codes
     * 
     * @param array $data
     *
     * @return LengthAwarePaginator|null
     */
    public function getAllEmployeesCodes(array $data): ?LengthAwarePaginator
    {
        try {
            $data = [
                'limit' => $data['limit'] ?? config('constants.DEFAULT_LIMIT'),
            ];

            return $this->employeeCodeRepository->getAllEmployeesCodes($data);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * Public function store employee code
     *
     * @param array $data
     *
     * @return array
     */
    public function storeEmployeeCode(array $data): array
    {
        try {
            DB::beginTransaction();

            if (!isset($data['file']) || !$data['file']->isValid()) {
                throw new \Exception('File không hợp lệ.', Response::HTTP_BAD_REQUEST);
            }

            $file = $data['file'];
            $handle = fopen($file->getRealPath(), 'r');
            $row = 0;
            $employeeCodes = [];
            $errors = [];

            $existingAccounts = $this->userRepository->getAccountRegisteredAndActive()
                ->mapWithKeys(fn($acc) => [$acc->code => $acc->email, $acc->email => $acc->code]);

            while (($line = fgetcsv($handle, 1000, ',')) !== false) {
                $row++;

                if ($row === 1) {
                    continue;
                }

                if (empty($line[0]) || empty($line[1]) || empty($line[2])) {
                    $errors[] = [
                        'row' => $row,
                        'message' => 'Dữ liệu ở các trường không đủ.',
                    ];

                    continue;
                }

                if (count($line) !== 3) {
                    $errors[] = [
                        'row' => $row,
                        'message' => 'Dòng dữ liệu không đúng định dạng.',
                    ];

                    continue;
                }

                [$code, $email, $name] = $line;

                // Check if code is not xxITxxx or vku then skip
                if (!preg_match('/^\d{2}IT\d{3}$/', $code) || !str_contains($email, config('constants.FORMAT_EMAIL_EMPLOYEE'))) {
                    $errors[] = [
                        'row' => $row,
                        'message' => 'Email hoặc mã sinh viên không đúng định dạng.',
                    ];

                    continue;
                }

                // Check if account is registered and active then skip
                if (isset($existingAccounts[$code]) || isset($existingAccounts[$email])) {
                    continue;
                }

                $employeeCodes[] = [
                    'code' => $code,
                    'email' => $email,
                    'name' => $name,
                    'updated_at' => now(),
                ];
            }

            if (!empty($errors)) {
                return [
                    'error' => $errors,
                    'error_code' => ERROR_BAD_REQUEST,
                    'code' => Response::HTTP_BAD_REQUEST,
                ];
            }

            if (!empty($employeeCodes) && $this->employeeCodeRepository->upsert($employeeCodes)) {
                DB::commit();

                return [
                    'message' => 'Thêm mới thông tin sinh viên thành công.',
                    'code' => Response::HTTP_OK,
                ];
            }

            throw new \Exception('Có lỗi xảy ra vui lòng thử lại sau.', Response::HTTP_BAD_REQUEST);
        } catch (\Exception $e) {
            Log::error($e->getMessage());
            DB::rollBack();

            return [
                'error' => $e->getMessage(),
                'error_code' => match ($e->getCode()) {
                    Response::HTTP_BAD_REQUEST => ERROR_BAD_REQUEST,
                    default => ERROR_CODE_INTERNAL_SERVER_ERROR
                },
                'code' => $e->getCode() ?? Response::HTTP_INTERNAL_SERVER_ERROR,
            ];
        }
    }
}
