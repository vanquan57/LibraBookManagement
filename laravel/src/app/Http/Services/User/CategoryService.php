<?php

namespace App\Http\Services\User;

use App\Http\Repositories\CategoryRepositoryInterface;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Log;

class CategoryService
{
    /**
     * Constructor
     *
     * @param CategoryRepositoryInterface $categoryRepository
     */
    public function __construct(
        protected CategoryRepositoryInterface $categoryRepository
    ) {}

    /**
     * Public function get all category
     *
     * @param array $dataSearch
     *
     * @param int $limit
     *
     * @return LengthAwarePaginator|null
     */
    public function getAllByPagination(array $dataSearch): ?LengthAwarePaginator
    {
        try {
            $data = [
                'search' => $dataSearch['search'] ?? null,
                'limit' => $dataSearch['limit'] ?? config('constants.DEFAULT_LIMIT'),
            ];

            return $this->categoryRepository->getAllByPagination($data);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }
}
