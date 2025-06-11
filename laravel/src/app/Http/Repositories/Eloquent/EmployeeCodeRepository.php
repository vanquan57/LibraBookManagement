<?php

namespace App\Http\Repositories\Eloquent;

use App\Http\Repositories\EmployeeCodeRepositoryInterface;
use App\Models\EmployeeCode;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Pagination\LengthAwarePaginator;

class EmployeeCodeRepository extends BaseRepository implements EmployeeCodeRepositoryInterface
{
    public function getModel(): string
    {
        return EmployeeCode::class;
    }

    /**
     * Check is employee kiaisoft
     *
     * @param string $employeeCode
     * 
     * @param string $email
     *
     * @return bool
     */
    public function checkIsEmployeeKiaisoft(string $employeeCode, string $email): bool
    {
        return $this->model->where('code', $employeeCode)->where('email', $email)->exists();
    }

    /**
     * Get all employees code
     * 
     * @param array $data
     *
     * @return LengthAwarePaginator|null
     */
    public function getAllEmployeesCodes(array $data): LengthAwarePaginator
    {
        return $this->model->paginate($data['limit']);
    }

    /**
     * Create or update employee code
     *
     * @param array $data
     *
     * @return int
     */
    public function upsert(array $data): int
    {
        return $this->model->upsert(
            $data,
            [
                'code',
                'email',
            ],
            [
                'name',
                'updated_at',
            ]
        );
    }
}
