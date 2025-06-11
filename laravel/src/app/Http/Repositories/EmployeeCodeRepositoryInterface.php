<?php

namespace App\Http\Repositories;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Pagination\LengthAwarePaginator;

interface EmployeeCodeRepositoryInterface extends BaseRepositoryInterface
{
    /**
     * Check is employee kiaisoft
     *
     * @param string $employeeCode
     * 
     * @param string $email
     *
     * @return bool
     */
    public function checkIsEmployeeKiaisoft(string $employeeCode, string $email): bool;

    /**
     * Get all employees code
     *
     * @return array $data
     * 
     * @return LengthAwarePaginator|null
     */
    public function getAllEmployeesCodes(array $data): LengthAwarePaginator;

    /**
     * Create or update employee code
     *
     * @return array $data
     * 
     * @return int
     */
    public function upsert(array $data): int;
}
