<?php

namespace App\Http\Services\User;

use App\Http\Repositories\BookRepositoryInterface;
use App\Http\Repositories\UserRepositoryInterface;
use App\Models\Book;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Log;

class WishListService
{
    /**
     * The constructor
     * 
     * @param BookRepositoryInterface $bookRepository
     * 
     * @param UserRepositoryInterface $userRepository
     */
    public function __construct(
        protected BookRepositoryInterface $bookRepository,
        protected UserRepositoryInterface $userRepository,
    ) {}

    /**
     * Get all my wish list
     * 
     * @return Collection|null
     */
    public function getAll(): ?Collection
    {
        try {
            $user = auth('api')->user();

            $books = $this->userRepository->getBooksInMyWishList($user);

            return $books;
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * Store a newly created wish list in storage
     * 
     * @param array $data
     * 
     * @return array
     */
    public function store(array $data): array
    {
        try {
            $user = auth('api')->user();

            $book = $this->bookRepository->find($data['book_id']);

            if (!$book) {
                throw new \Exception('Không tìm thấy sách.', Response::HTTP_NOT_FOUND);
            }

            if ($this->userRepository->checkBookInWishList($user, $data['book_id'])) {
                throw new \Exception('Sách đã có trong danh sách yêu thích.', Response::HTTP_BAD_REQUEST);
            }

            if (!$this->userRepository->addBookToWishList($user, $data['book_id'])) {
                throw new \Exception('Thêm sách vào danh sách yêu thích thất bại.', Response::HTTP_INTERNAL_SERVER_ERROR);
            }

            return [
                'message' => 'Đã thêm sách vào danh sách yêu thích thành công.',
                'code' => Response::HTTP_CREATED,
            ];
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return [
                'error' => $e->getMessage(),
                'error_code' => match ($e->getCode()) {
                        Response::HTTP_BAD_REQUEST => ERROR_BAD_REQUEST,
                        Response::HTTP_NOT_FOUND => ERROR_CODE_NOT_FOUND,
                        default => ERROR_CODE_INTERNAL_SERVER_ERROR
                },
                'code' => $e->getCode(),
            ];
        }
    }

    /**
     * Remove the specified wish list from storage
     * 
     * @param int $bookId
     * 
     * @return bool
     */
    public function destroy(int $bookId): bool
    {
        try {
            $user = auth('api')->user();

            if (!$this->userRepository->checkBookInWishList($user, $bookId)) {
                return false;
            }

            if (!$this->userRepository->destroyBookFromWishList($user, $bookId)) {
                return false;
            }

            return true;
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return false;
        }
    }
}
