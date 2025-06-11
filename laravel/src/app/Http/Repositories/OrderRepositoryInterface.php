<?php

namespace App\Http\Repositories;

use App\Models\Book;
use App\Models\Order;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Collection;
use Illuminate\Pagination\LengthAwarePaginator;

interface OrderRepositoryInterface extends BaseRepositoryInterface
{
    /**
     * Get all orders by paginate
     *
     *  @param array $data
     * 
     * @return LengthAwarePaginator
     */
    public function getAllByPaginate(array $data): LengthAwarePaginator;

    /**
     * Get details of the order
     *
     * @param int $id
     *
     * @return Order|null
     */
    public function getDetails(int $id): ?Order;

    /**
     * Update status book in order
     *
     * @param array $data
     *
     * @param int $orderId
     *
     * @return Model|null
     */
    public function getBookInOrder(array $data, int $orderId): ?Model;

    /**
     * Get overall order status
     *
     * @param int $orderId
     *
     * @return Collection
     */
    public function getOverallOrderStatus(int $orderId): Collection;

    /**
     * Update status book in order with note
     * 
     * @param Book $book
     * 
     * @param string $note
     * 
     * @return bool
    */
    public function updateStatusBookInOrderWithNote(Book $book, string $note): bool;

    /**
     * Update status book in order
     * 
     * @param Book $book
     * 
     * @param array $data
     * 
     * @return bool
    */
    public function updateStatusBookInOrder(Book $book, array $data): bool;

    /**
     * Get all order overdue
     *
     * @return Collection
     */
    public function getAllOrderOverdue(): Collection;

    /**
     * Update status multiple order is overdue
     * 
     * @param array $idsOrder
     * 
     * @return bool
     */
    public function updateStatusMultipleOrderIsOverdue(array $idsOrder): bool;

    /**
     * Get total orders month and year
     * 
     * @param Carbon $startMonth
     * 
     * @param Carbon $currentMonth
     * 
     * @return array|null
     */
    public function getTotalOrdersByMonthAndYear(Carbon $startMonth, Carbon $currentMonth): ?array;

    /**
     * The method count total order in table
     * 
     * @return int
     */
    public function countOrders(): int;

    /**
     * The method get details in my order table
     * 
     * @param User $user
     * 
     * @param int $orderId
     * 
     * @return Model|null
     */
    public function getOrderDetailsInMyOrder(User $user, int $orderId): ?Model;
}
