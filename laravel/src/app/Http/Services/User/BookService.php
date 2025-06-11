<?php

namespace App\Http\Services\User;

use App\Http\Repositories\BookRepositoryInterface;
use App\Models\Book;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

class BookService
{
    /**
     * Constructor
     *
     * @param BookRepositoryInterface $bookRepository
     *
     * @param ImageService $imageService
     *
     */
    public function __construct(
        protected BookRepositoryInterface $bookRepository
    ) {}

    /**
     * Get all books by paginate
     *
     * @param array $dataSearch
     *
     * @return LengthAwarePaginator|null
     */
    public function getAllByPaginationForSiteUser($dataSearch): ?LengthAwarePaginator
    {
        try {
            $data = [
                'name' => $dataSearch['name'] ?? null,
                'limit' => $dataSearch['limit'] ?? config('constants.DEFAULT_LIMIT'),
                'author_id' => $dataSearch['author_id'] ?? null,
                'publisher_id' => $dataSearch['publisher_id'] ?? null,
                'category_id' => $dataSearch['category_id'] ?? null,
                'order' => $dataSearch['order'] ?? 'asc',
                'most_borrowed' => $dataSearch['most_borrowed'] ?? null,
                'most_viewed' => $dataSearch['most_viewed'] ?? null,
                'latest' => $dataSearch['latest'] ?? null,
                'most_loved' => $dataSearch['most_loved'] ?? null,
            ];

            return $this->bookRepository->getAllByPaginationForSiteUser($data);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * Show a book
     *
     * @param int $id
     *
     * @return Book|null
     */
    public function show(int $id): ?Book
    {
        try {
            return $this->bookRepository->find($id);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * Update view count
     *
     * @param int $id
     *
     * @return bool
     */
    public function updateViewCount(int $id): bool
    {
        try {
            $book = $this->bookRepository->find($id);

            if (!$book) {
                return false;
            }

            return $this->bookRepository->updateBookViewCount($book);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return false;
        }
    }
}
