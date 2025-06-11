<?php

namespace App\Http\Repositories;

use App\Models\Book;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;

interface BookRepositoryInterface extends BaseRepositoryInterface
{
    /**
     * Get all books by paginate
     *
     * @param array $data
     *
     * @return LengthAwarePaginator|null
     */
    public function getAllByPagination(array $data): ?LengthAwarePaginator;

    /**
     * Get all books by paginate for site user
     *
     * @param array $data
     *
     * @return LengthAwarePaginator|null
     */
    public function getAllByPaginationForSiteUser(array $data): ?LengthAwarePaginator;
    
    /**
     * Add a book to category
     *
     * @param int $bookId
     *
     * @param int $categoryId
     *
     * @return bool
     */
    public function addBookToCategory(int $bookId, int $categoryId): bool;

    /**
     * Update book in category
     *
     * @param int $bookId
     *
     * @param int $categoryId
     *
     * return bool
     */
    public function updateBookInCategory(int $bookId, int $categoryId): bool;

    /**
     * Get all id of books by query like name
     * 
     * @param string $name
     * 
     * @return array
    */
    public function getIdsByName(string $name): array;

    /**
     * Get top books most popular
     * 
     * @param array $data
     *
     * @return Collection|null
     */
    public function getTopBooksMostPopular(array $data): ?Collection;

     /**
     * Get data for line chart top books most likely
     * 
     * @param array $data
     * 
     * @return Collection|null
     */
    public function getTopMostLikesBook(array $data): ?Collection;

    /**
     * Update view book 
     * 
     * @param Book $book
     * 
     * @return int
     */
    public function updateBookViewCount(Book $book): int;

    /**
     * Find many book by ids
     * 
     * @param array $ids
     * 
     * @return Collection
    */
    public function findManyByIds(array $ids): Collection;

    /**
     * Update multiple records to the cart
     * 
     * @param array $data
     * 
     * @return int
    */
    public function upsert(array $data): int;
}
