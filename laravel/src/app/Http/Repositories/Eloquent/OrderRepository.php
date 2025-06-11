<?php

namespace App\Http\Repositories\Eloquent;

use App\Http\Repositories\OrderRepositoryInterface;
use App\Models\Book;
use App\Models\Order;
use App\Models\OrderDetail;
use App\Models\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Collection;
use Carbon\Carbon;
use Illuminate\Pagination\LengthAwarePaginator;

class OrderRepository extends BaseRepository implements OrderRepositoryInterface
{
    public function getModel(): string
    {
        return Order::class;
    }

    /**
     * Get all orders by paginate
     * 
     * @param array $data
     *
     * @return LengthAwarePaginator
     */
    public function getAllByPaginate($data): LengthAwarePaginator
    {
        $query = $this->model->query();

        if (!empty($data['user_id'])) {
            $query->where('user_id', $data['user_id']);
        }

        if (!empty($data['key_word'])) {
            $query->where(function ($query) use ($data) {
                $query->whereHas('user', function ($query) use ($data) {
                    // Name of user
                    $query->where('name', 'like', '%' . $data['key_word'] . '%');
                })
                    // Or email of register in order
                    ->orWhere('email', 'like', '%' . $data['key_word'] . '%');
            });
        }

        if (!empty($data['start_date'])) {
            if (!empty($data['end_date'])) {
                $query->whereBetween('created_at', [$data['start_date'], $data['end_date']]);
            }

            $query->whereBetween('created_at', [$data['start_date'], now()]);
        }
        
        if (!empty($data['status'])) {
            $query->where('status', $data['status']);
        }

        if (!empty($data['column']) && !empty($data['order'])) {
            $query->orderBy($data['column'], $data['order']);
        }

        return $query->withCount('orderDetails')
            ->with('user:id,name,email')
            ->paginate($data['limit']);
    }

    /**
     * Get details of the order
     *
     * @param int $id
     *
     * @return Order|null
     */
    public function getDetails(int $id): ?Order
    {
        return $this->model->with([
            'user:id,name,email',
            'orderDetails',
        ])->find($id);
    }

    /**
     * Update status book in order
     *
     * @param array $data
     *
     * @param int $orderId
     *
     * @return Model|null
     */
    public function getBookInOrder(array $data, int $orderId): ?Model
    {
        $order = $this->model->findOrFail($orderId);

        return $order->orderDetails()->where('book_id', $data['book_id'])->first();
    }

    /**
     * Get overall order status
     *
     * @param int $orderId
     *
     * @return Collection
     */
    public function getOverallOrderStatus(int $orderId): Collection
    {
        $order = $this->model->findOrFail($orderId);

        return $order->orderDetails->pluck('pivot.status');
    }

    /**
     * Update status book in order with note
     * 
     * @param Book $book
     * 
     * @param string $note
     * 
     * @return bool
    */
    public function updateStatusBookInOrderWithNote(Book $book, string $note): bool
    {
        $book->pivot->status = OrderDetail::STATUS_MISSING;
        $book->pivot->note = $note;

        return $book->pivot->save();
    }

    /**
     * Update status book in order
     * 
     * @param Book $book
     * 
     * @param array $data
     * 
     * @return bool
    */
    public function updateStatusBookInOrder(Book $book, array $data): bool
    {
        $book->pivot->status = $data['status'];
        
        return $book->pivot->save();
    }

    /**
     * Get all order overdue
     *
     * @return Collection
     */
    public function getAllOrderOverdue(): Collection
    {
        return $this->model->where('status', '!=', Order::STATUS_RETURNED)
            ->with([
                'orderDetails' => function ($query) {
                    $query->where('status', '!=', OrderDetail::STATUS_RETURNED)
                        ->whereDate('return_date', '<', Carbon::now());
                }
            ])
            ->get();
    }

    /**
     * Update status multiple order is overdue
     * 
     * @param array $idsOrder
     * 
     * @return bool
     */
    public function updateStatusMultipleOrderIsOverdue(array $idsOrder): bool
    {
        return $this->model->whereIn('id', $idsOrder)->update(['status' => Order::STATUS_OVERDUE]);
    }

    /**
     * Get total orders by specific month and year
     * 
     * @param Carbon $startMonth
     * 
     * @param Carbon $currentMonth
     * 
     * @return array|null
     */
    public function getTotalOrdersByMonthAndYear(Carbon $startMonth, Carbon $currentMonth): ?array
    {
        return $this->model->selectRaw('DATE_FORMAT(created_at, "%m-%Y") as month_year, COUNT(id) as total_orders')
        ->whereBetween('created_at', [$startMonth, $currentMonth])
        ->groupBy('month_year')
        ->orderByRaw('MIN(created_at)')
        ->get()
        ->pluck('total_orders', 'month_year')
        ->toArray();
    }

    /**
     * Store the order
     * 
     * @param array $data
     * 
     * @return Model
    */
    public function store(array $data): Model
    {
        return $this->model->create([
            'user_id' => $data['user_id'],
            'code' => $data['code'],
            'name' => $data['name'],
            'email' => $data['email'],
            'phone' => $data['phone'],
            'province_id' => $data['province_id'],
            'district_id' => $data['district_id'],
            'ward_id' => $data['ward_id'],
            'address' => $data['address'],
            'status' => Order::STATUS_BORROWING,
        ]);
    }

    /**
     * The method count total order in table
     * 
     * @return int
     */
    public function countOrders(): int
    {
        return $this->model->orderByDesc('id')->value('id');
    }

    /**
     * The method get details in my order table
     * 
     * @param User $user
     * 
     * @param int $orderId
     * 
     * @return Model|null
     */
    public function getOrderDetailsInMyOrder(User $user, int $orderId): ?Model
    {
        return $user->orders()->where('id', $orderId)->with([
            'user:id,name,email',
            'orderDetails',
        ])->first();
    }
}
