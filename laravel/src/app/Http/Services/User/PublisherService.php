<?php

namespace App\Http\Services\User;

use App\Http\Repositories\PublisherRepositoryInterface;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Log;

class PublisherService
{
    /**
     * Constructor.
     *
     * @param PublisherRepositoryInterface $publisherRepository
     */
    public function __construct(
        protected PublisherRepositoryInterface $publisherRepository
    ) {}

    /**
     * Get all publishers.
     *
     * @param array $dataSearch
     *
     * @return LengthAwarePaginator|null
     */
    public function getAllByPaginate(array $dataSearch): ?LengthAwarePaginator
    {
        try {
            $data = [
                'search' => $dataSearch['search'] ?? null,
                'limit' => $dataSearch['limit'] ?? config('constants.DEFAULT_LIMIT')
            ];

            return $this->publisherRepository->getAllByPaginate($data);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }
}
