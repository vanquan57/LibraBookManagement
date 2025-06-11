<?php

namespace App\Http\Repositories;

interface ImageRepositoryInterface extends BaseRepositoryInterface
{
    /**
     * Store multiple images by book id
     *
     * @param int $bookId
     *
     * @param array $images
     *
     * @return bool
     */
    public function storeImagesByBookId(int $bookId, array $images): bool;

    /**
     * destroy images by book id
     *
     * @param int $bookId
     *
     * @return bool
     */
    public function destroy(int $bookId): bool;

    /**
     * Get all images by bookId
     *
     * @param int $bookId
     *
     * @return array
     */
    public function getAllByBookId(int $bookId): array;
}
