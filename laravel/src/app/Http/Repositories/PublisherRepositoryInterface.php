<?php

namespace App\Http\Repositories;

use Illuminate\Pagination\LengthAwarePaginator;

interface PublisherRepositoryInterface extends BaseRepositoryInterface
{
    /**
     * Get all publishers by paginate.
     *
     * @param array $data
     *
     * @return LengthAwarePaginator
     */
    public function getAllByPaginate(array $data): LengthAwarePaginator;
}
