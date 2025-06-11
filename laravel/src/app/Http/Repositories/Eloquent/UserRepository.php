<?php

namespace App\Http\Repositories\Eloquent;

use App\Http\Repositories\UserRepositoryInterface;
use App\Models\Book;
use App\Models\User;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Pagination\LengthAwarePaginator;

class UserRepository extends BaseRepository implements UserRepositoryInterface
{
    public function getModel(): string
    {
        return User::class;
    }

    /**
     * Get all users pagination
     *
     * @param array $data
     *
     * @return LengthAwarePaginator
     */
    public function getAllByPagination(array $data): LengthAwarePaginator
    {
        $query = $this->model->query()->with([
            'district:id,name',
            'province:id,name',
            'ward:id,name',
        ])->where('role', User::ROLE_USER);

        if (!empty($data['key_word'])) {
            $query->where(function ($query) use ($data) {
                $query->where('code', 'like', '%' . $data['key_word'] . '%')
                    ->orWhere('email', 'like', '%' . $data['key_word'] . '%')
                    ->orWhere('name', 'like', '%' . $data['key_word'] . '%');
            });
        }

        if (!empty($data['column']) && !empty($data['order'])) {
            $query->orderBy($data['column'], $data['order']);
        }

        if(!empty($data['status'])) {
            $query->where('status', $data['status']);
        }

        return $query->paginate($data['limit']);
    }

    /**
     * Get account is registered and active
     * 
     * @return Collection|null
     */
    public function getAccountRegisteredAndActive() : ?Collection
    {
        return $this->model
            ->where('status', User::STATUS_ACTIVE)
            ->get(['code', 'email']);
    }

    /**
     * Get top user most orders
     * 
     * @param array $data
     * 
     * @return Collection|null
     */
    public function getTopUsersMostOder(array $data): ?Collection
    {
        return $this->model->select('name')->where('role', User::ROLE_USER)
            ->withCount('orders')
            ->orderBy('orders_count', $data['order_by_type'])
            ->take($data['limit'])
            ->get();
    }

    /**
     * Find the user with google id
     *
     * @param string $googleId
     *
     * @return User|null
     */
    public function findByGoogleId(string $googleId): ?User
    {
        return $this->model->where('google_id', $googleId)
            ->where('status', User::STATUS_ACTIVE)->first();
    }

    /**
     * get registered google account
     *
     * @param string $code
     *
     * @param string $email
     * 
     * @return User|null
     */
    public function getRegisteredAccount(string $code, string $email): ?User
    {
        return $this->model->where('code', $code)
            ->where('email', $email)->first();
    }

    /**
     * Check exists account register
     * 
     * @param string $code
     * 
     * @param string $email
     * 
     * @return bool
     */
    public function checkExistsAccountRegister(string $code, string $email): bool
    {
        return $this->model->where('code', $code)
            ->orWhere('email', $email)->exists();
    }

    /**
     * Update info password when mapping account google
     * 
     * @param User $user
     * 
     * @param array $data
     * 
     * @return bool
    */
    public function updateInfoWhenMappingAccountGoogle(User $user, array $data): bool
    {
        $user->name = $data['name'];
        $user->password = bcrypt($data['password']);

        return $user->save();
    }

    /**
     * Update info when mapping account register with email password
     * 
     * @param User $user
     * 
     * @param string $googleId
     * 
     * @return bool
    */
    public function updateInfoWhenMappingAccountEmailPassword(User $user, string $googleId): bool
    {
        $user->google_id = $googleId;

        return $user->save();
    }

    /**
     * The function store account information
     * 
     * @param array $data
     * 
     * @return Model
     */
    public function store(array $data): Model
    {
        return $this->model->create([
            'code' => $data['code'],
            'name'=> $data['name'],
            'email' => $data['email'],
            'password' => bcrypt($data['password']),
            ... $data
        ]);
    }

    /**
     * Register google account information
     * 
     * @param string $code
     *
     * @param object $userGoogle
     * 
     * @return Model
    */
    public function registerGoogle(string $code, object $userGoogle): Model
    {
        return $this->model->create([
            'code'=> $code,
            'email' => $userGoogle->user['email'],
            'name' => $userGoogle->user['name'],
            'google_id' => $userGoogle->user['sub'],
            'status' => User::STATUS_ACTIVE,
        ]);
    }

    /**
     * Find the user with email
     *
     * @param string $email
     *
     * @return User|null
     */
    public function findByEmail(string $email): ?User
    {
        return $this->model->where('email', $email)
            ->where('role', User::ROLE_USER)
            ->first();
    }

    /**
     * Update password user
     *
     * @param int $userId
     * 
     * @param string $password
     *
     * @return bool
     */
    public function updatePassword(int $userId, string $password): bool
    {
        return $this->model->where('id', $userId)
            ->update([
                'password' => bcrypt($password)
            ]);
    }

    /**
     * Commit a transaction
     *
     * @param User $user
     * 
     * @return bool
     */
    public function commitChanges(User $user): bool
    {
        return $user->save();
    }

    /**
     * Show details information of user
     *
     * @param int $id
     *
     * @return User|null
     */
    public function showDetails(int $id): ?User
    {
        return $this->model->with([
            'province:id,name',
            'district:id,name',
            'ward:id,name',
        ])->find($id);
    }

    /**
     * Update information user
     *
     * @param int $userId
     * 
     * @param array $data
     *
     * @return bool
     */
    public function updateInformation(int $userId, array $data): bool
    {
        return $this->model->where('id', $userId)
            ->update([
                'name' => $data['name'],
                'province_id' => $data['province_id'],
                'district_id' => $data['district_id'],
                'ward_id' => $data['ward_id'],
                'address' => $data['address']
            ]);
    }

    /**
     * Check book is in wish list
     * 
     * @param User $user
     * 
     * @param int $bookId
     * 
     * @return bool
    */
    public function checkBookInWishList(User $user, int $bookId): bool
    {
        return $user->wishLists()->where('book_id', $bookId)->exists();
    }

    /**
     * Get wish list of user
     * 
     * @param User $user
     *
     * @return Collection|null
    */
    public function getBooksInMyWishList(User $user): ?Collection
    {
        $books = $user->wishLists()->with([
            'author:id,name',
            'publisher:id,name',
        ])->withCount('feedbacks')->get();

        return $books;
    }

    /**
     * Add book to my wish list
     * 
     * @param User $user
     * 
     * @param int $bookId
     * 
     * @return bool
    */
    public function addBookToWishList(User $user, int $bookId): bool
    {
        $user->wishLists()->attach($bookId);
        $user->refresh();

        return $user->wishLists()->where('book_id', $bookId)->exists();
    }

    /**
     * Remove book from my wish list
     * 
     * @param User $user
     * 
     * @param int $bookId
     * 
     * @return int
    */
    public function destroyBookFromWishList(User $user, int $bookId): int
    {
        return $user->wishLists()->detach($bookId);
    }

    /**
     * Get book in cart of user
     * 
     * @param User $user
     *
     * @return Collection|null
     * 
    */
    public function getAllBookInCart(User $user): ?Collection
    {
        return $user->books()->withPivot('quantity')->get();
    }

    /**
     * Get book exiting in cart of user
     *
     * @param User $user 
     * 
     * @param int $bookId
     * 
     * @return Model|null
     */
    public function getBookExitingInCart(User $user, int $bookId): ?Model
    {
        return $user->books()->wherePivot('book_id', $bookId)->first();
    }

    /**
     * Delete book in cart of user
     * 
     * @param User $user
     * 
     * @param int $bookId
     * 
     * @return int
     */
    public function destroyBookInCart(User $user, int $bookId): int
    {
        return $user->books()->detach($bookId);
    }
}
