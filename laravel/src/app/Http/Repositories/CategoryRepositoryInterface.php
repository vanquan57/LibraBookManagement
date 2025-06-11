<?php

namespace App\Http\Repositories;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;

interface CategoryRepositoryInterface extends BaseRepositoryInterface
{
    /**
     * Get categories by paginate
     *
     * @param array $data
     *
     * @return LengthAwarePaginator
     */
    public function getAllByPagination(array $data): LengthAwarePaginator;

    /**
     * Get data for pie chart categories
     * 
     * @return Collection|null
     */
    public function getTotalBooksInCategories(): ?Collection;
}
