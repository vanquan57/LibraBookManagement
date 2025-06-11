<?php

namespace App\Http\Repositories;

use App\Models\Book;
use Illuminate\Database\Eloquent\Collection;
use App\Models\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Pagination\LengthAwarePaginator;

interface UserRepositoryInterface extends BaseRepositoryInterface
{
    /**
     * Get all users pagination
     *
     * @param array $data
     *
     * @return LengthAwarePaginator
     */
    public function getAllByPagination(
        array $data,
    ): LengthAwarePaginator;

    /**
     * Get account is registered and active
     * 
     * @return Collection|null
     */
    public function getAccountRegisteredAndActive(): ?Collection;

    /**
     * Get top user most orders
     * 
     * @param array $data
     * 
     * @return Collection|null
     */
    public function getTopUsersMostOder(array $data): ?Collection;

    /**
     * Find the user with google id
     *
     * @param string $googleId
     *
     * @return User|null
     */
    public function findByGoogleId(string $googleId): ?User;

    /**
     * Get registered account
     *
     * @param string $employeeCode
     * 
     * @param string $email
     *
     * @return User|null
     */
    public function getRegisteredAccount(string $employeeCode, string $email): ?User;

    /**
     * Check exists account register
     * 
     * @param string $employeeCode
     * 
     * @param string $email
     * 
     * @return bool
    */
    public function checkExistsAccountRegister(string $employeeCode, string $email): bool;

    /**
     * Update info password when mapping account google
     * 
     * @param User $user
     * 
     * @param array $data
     * 
     * @return bool
    */
    public function updateInfoWhenMappingAccountGoogle(User $user, array $data): bool;

    /**
     * Update info when mapping account register with email password
     * 
     * @param User $user
     * 
     * @param string $googleId
     * 
     * @return bool
    */
    public function updateInfoWhenMappingAccountEmailPassword(User $user, string $googleId): bool;

    /**
     * Register google account information
     * 
     * @param string $code
     * 
     * @param object $userGoogle
     * 
     * @return Model
    */
    public function registerGoogle(string $code, object $userGoogle): Model;

    /**
     * Find the user with email
     *
     * @param string $email
     *
     * @return Model|null
     */
    public function findByEmail(string $email): ?Model;

    /**
     * Update password user
     *
     * @param int $userId
     * 
     * @param string $password
     *
     * @return bool
     */
    public function updatePassword(int $userId, string $password): bool;

    /**
     * Commit a transaction
     *
     * @param User $user
     * 
     * @return bool
     */
    public function commitChanges(User $user): bool;

    /**
     * Show details information of user
     *
     * @param int $id
     *
     * @return Model|null
     */
    public function showDetails(int $id): ?Model;

    /**
     * Update information user
     *
     * @param int $userId
     * 
     * @param array $data
     *
     * @return bool
     */
    public function updateInformation(int $userId, array $data): bool;

     /**
     * Get wish list of user
     * 
     * @param User $user
     *
     * @return Collection|null
    */
    public function getBooksInMyWishList(User $user): ?Collection;

    /**
     * Check book is in wish list
     * 
     * @param User $user
     * 
     * @param int $bookId
     * 
     * @return bool
    */
    public function checkBookInWishList(User $user, int $bookId): bool;

    /**
     * Add book to my wish list
     * 
     * @param User $user
     * 
     * @param int $bookId
     * 
     * @return bool
    */
    public function addBookToWishList(User $user, int $bookId): bool;

    /**
     * Remove book from my wish list
     * 
     * @param User $user
     * 
     * @param int $bookId
     * 
     * @return int
    */
    public function destroyBookFromWishList(User $user, int $bookId): int;

    /**
     * Get book in cart of user
     * 
     * @param User $user
     *
     * @return Collection|null
     * 
    */
    public function getAllBookInCart(User $user): ?Collection;

    /**
     * Get book exiting in cart of user
     *
     * @param User $user 
     * 
     * @param int $bookId
     * 
     * @return Model|null
     */
    public function getBookExitingInCart(User $user, int $bookId): ?Model;

    /**
     * Delete book in cart of user
     * 
     * @param User $user
     * 
     * @param int $bookId
     * 
     * @return int
     */
    public function destroyBookInCart(User $user, int $bookId): int;
}
