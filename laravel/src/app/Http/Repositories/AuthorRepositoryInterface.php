<?php

namespace App\Http\Repositories;

use Illuminate\Pagination\LengthAwarePaginator;

interface AuthorRepositoryInterface extends BaseRepositoryInterface
{
    /**
     * Get all authors by paginate
     *
     * @param $data
     *
     * @return LengthAwarePaginator
     */
    public function getAllByPaginate(array $data): LengthAwarePaginator;
}
