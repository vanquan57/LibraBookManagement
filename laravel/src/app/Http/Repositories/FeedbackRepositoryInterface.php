<?php

namespace App\Http\Repositories;

use App\Models\Book;
use Illuminate\Pagination\LengthAwarePaginator;

interface FeedbackRepositoryInterface extends BaseRepositoryInterface
{
    /**
     * Get all feedbacks by paginate
     *
     * @param array $data
     * 
     * @return LengthAwarePaginator|null
     */
    public function getAllByPaginate(array $data): ?LengthAwarePaginator;

    /**
     * Update the feedback status
     *
     * @param int $id
     *
     * @return bool
     */
    public function updateStatus(int $id): bool;

    /**
     * Get feedbacks by book id.
     *
     * @param Book $book
     * 
     * @param array $data
     * 
     * @return LengthAwarePaginator|null
     */
    public function getFeedbacksByBookId(Book $book, array $data): ?LengthAwarePaginator;
}
