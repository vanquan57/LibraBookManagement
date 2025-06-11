<?php

namespace App\Http\Services;

use App\Http\Repositories\CategoryRepositoryInterface;
use App\Models\Category;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Http\Response;
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
                'name' => $dataSearch['name'] ?? null,
                'limit' => $dataSearch['limit'] ?? config('constants.DEFAULT_LIMIT'),
                'column' => $dataSearch['column'] ?? null,
                'order' => $dataSearch['order'] ?? null,
            ];

            return $this->categoryRepository->getAllByPagination($data);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * Public function store category
     *
     * @param array $data
     *
     * @return Category|null
     */
    public function store(array $data): ?Category
    {
        try {
            $data['slug'] = $data['name'];

            return $this->categoryRepository->store($data);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * Public function show category
     *
     * @param int $id
     *
     * @return Category|null
     */
    public function show(int $id) : ?Category
    {
        try {
            return $this->categoryRepository->find($id);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * Public function update category
     *
     * @param array $data
     *
     * @param int $id
     *
     * @return bool
     */
    public function update(array $data, int $id): bool
    {
        try {
            $category = $this->categoryRepository->find($id);

            if (empty($category)) {
                return false;
            }

            $data['slug'] = $data['name'];

            return $this->categoryRepository->update($id, $data);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return false;
        }
    }

    /**
     * Public function destroy category
     *
     * @param int $id
     *
     * @return bool
     */
    public function destroy(int $id): bool
    {
        try {
            return $this->categoryRepository->destroy($id);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return false;
        }
    }
}
