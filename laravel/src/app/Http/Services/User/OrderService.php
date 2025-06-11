<?php

namespace App\Http\Services\User;

use App\Http\Repositories\BookRepositoryInterface;
use App\Http\Repositories\OrderDetailsRepositoryInterface;
use App\Http\Repositories\OrderRepositoryInterface;
use App\Models\Book;
use App\Models\Order;
use App\Models\OrderDetail;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Http\Response;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class OrderService
{
    /**
     * The constructor
     *
     * @param OrderRepositoryInterface $orderRepository
     * 
     * @param BookRepositoryInterface $bookRepository
     * 
     * @param OrderDetailsRepositoryInterface $orderDetailsRepository
     */
    public function __construct(
        protected OrderRepositoryInterface $orderRepository,
        protected BookRepositoryInterface $bookRepository,
        protected OrderDetailsRepositoryInterface $orderDetailsRepository
    ) {}

    /**
     * Get all orders by paginate
     *
     *  @param array $dataSearch
     * 
     * @return LengthAwarePaginator|null
     */
    public function getAllByPaginate(array $dataSearch): ?LengthAwarePaginator
    {
        try {
            $user = auth('api')->user();

            $data = [
                'user_id' => $user->id,
                'start_date' => $dataSearch['start_date'] ?? null,
                'end_date' => $dataSearch['end_date'] ?? null,
                'status' => $dataSearch['status'] ?? null,
                'limit' => $dataSearch['limit'] ?? config('constants.DEFAULT_LIMIT'),
                'column' => $dataSearch['column'] ?? null,
                'order' => $dataSearch['order'] ?? null,
            ];

            return $this->orderRepository->getAllByPaginate($data);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * Store a new order
     *
     * @param array $data
     *
     * @return array
     */
    public function store(array $data): array
    {
        try {
            DB::beginTransaction();

            $user = auth('api')->user();

            $data['user_id'] = $user->id;
            $currentCount = $this->orderRepository->countOrders();
            $nextNumber = $currentCount + 1;

            if ($nextNumber > 99999) {
                $orderCode = 'HD' . $nextNumber;
            } else {
                $orderCode = 'HD' . str_pad($nextNumber, 5, '0', STR_PAD_LEFT);
            }

            $data['code'] = $orderCode;

            $order = $this->orderRepository->store($data);

            $bookIds = array_column($data['order_details'], 'book_id');
            $books = $this->bookRepository->findManyByIds($bookIds)->keyBy('id');

            if (
                $order &&
                $this->checkQuantityForMultipleBooks($data['order_details'], $books) &&
                $this->addBookToOrder($order, $data['order_details']) &&
                $this->updateBooksInfo($data['order_details'], $books)
            ) {
                DB::commit();

                return [
                    'message' => 'Tiến hành mượn sách thành thành công',
                    'code' => Response::HTTP_CREATED,
                ];
            }
            
            throw new \Exception('Có lỗi xảy ra vui lòng thử lại sau.', Response::HTTP_BAD_REQUEST);
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error($e->getMessage());

            return [
                'error' => $e->getMessage(),
                'error_code' => match ($e->getCode()) {
                    Response::HTTP_BAD_REQUEST => ERROR_BAD_REQUEST,
                    Response::HTTP_UNAUTHORIZED => ERROR_CODE_AUTHENTICATE,
                    default => ERROR_CODE_INTERNAL_SERVER_ERROR
                },
                'code' => $e->getCode(),
            ];
        }
    }

    /**
     * Get details of the order
     *
     * @param int $id
     *
     * @return Order|null
     */
    public function show(int $id): ?Order
    {
        try {
            $user = auth('api')->user();

            return $this->orderRepository->getOrderDetailsInMyOrder($user, $id);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * Update status book in order
     *
     * @param array $data
     *
     * @param int $id
     *
     * @return bool
     */
    public function update(array $data, int $id): bool
    {
        try {
            DB::beginTransaction();

            $user = auth('api')->user();

            if (!$this->orderRepository->getOrderDetailsInMyOrder($user, $id)) {
                throw new \Exception('Không tìm thấy đơn mượn hoặc bạn không có quyền sửa.');
            }

            $book = $this->orderRepository->getBookInOrder($data, $id);

            if (
                $this->updateStatusBookInOrder($book, $data) &&
                $this->updateOrderStatus($id, $this->getOverallOrderStatus($id))
            ) {
                DB::commit();

                return true;
            }
            
            throw new \Exception('Cập nhật trạng thái đơn mượn thất bại');
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error($e->getMessage());

            return false;
        }
    }

    /**
     * Get overall order status
     *
     * @param int $orderId
     *
     * @return int
     */
    private function getOverallOrderStatus(int $orderId): int
    {
        $statuses = $this->orderRepository->getOverallOrderStatus($orderId);

        // If order has only one book then return status of that book
        if ($statuses->count() === 1) {
            return $statuses->first();
        }

        // If order has only one overdue book then return overdue status
        if ($statuses->contains(OrderDetail::STATUS_OVERDUE)) {
            return Order::STATUS_OVERDUE;
        }

        // If order has only one missing book then return missing status
        if ($statuses->contains(OrderDetail::STATUS_MISSING)) {
            return Order::STATUS_MISSING;
        }

        // If order has only one borrowing book then return borrowing status
        if ($statuses->contains(OrderDetail::STATUS_BORROWING)) {
            return Order::STATUS_BORROWING;
        }

        return Order::STATUS_RETURNED;
    }

    /**
     * Add book to order
     * 
     * @param Order $order
     * 
     * @param array $orderDetails
     */
    private function addBookToOrder(Order $order, array $orderDetails): bool
    {
        $dataOrderDetailsInsert = [];

        foreach ($orderDetails as $orderDetail) {
            $dataOrderDetailsInsert[] = [
                'order_id' => $order->id,
                'book_id' => $orderDetail['book_id'],
                'quantity' => $orderDetail['quantity'],
                'borrow_date' => Carbon::now(),
                'return_date' => $orderDetail['return_date'],
                'note' => $orderDetail['note'] ?? null,
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ];
        }

        return $this->orderDetailsRepository->insert($dataOrderDetailsInsert);
    }

    /**
     * Update status order
     *
     * @param int $orderId,
     * 
     * @param int $orderStatus
     *
     * @return bool
     */
    private function updateOrderStatus(int $orderId, int $orderStatus): bool
    {
        try {
            return $this->orderRepository->update($orderId, [
                'status' => $orderStatus,
            ]);
        } catch (\Exception $e) {
            return false;
        }
    }

    /**
     * Check quantity for multiple books
     * 
     * @param array $orderDetails
     * 
     * @param Collection $books
     * 
     * @return bool
     */
    private function checkQuantityForMultipleBooks(array $orderDetails, Collection $books): bool
    {
        foreach ($orderDetails as $orderDetail) {
            $book = $books[$orderDetail['book_id']];

            if ($book->quantity < $orderDetail['quantity']) {
                return false;
            }
        }

        return true;
    }

    /**
     * Update multiple books
     *
     * @param array $orderDetails
     * 
     * @param Collection $books
     *
     * @return bool
     */
    private function updateBooksInfo(array $orderDetails, Collection $books): bool
    {
        $dataUpdateBooks = [];

        foreach ($orderDetails as $orderDetail) {
            $book = $books[$orderDetail['book_id']] ?? null;

            if (!$book) {
                return false;
            }

            $dataUpdateBooks[] = [
                ...$book->getAttributes(),
                'quantity' => $book->quantity - $orderDetail['quantity'],
                'borrowing_number' => $book->borrowing_number + 1,
                'updated_at' => Carbon::now(),
            ];
        }

        return $this->bookRepository->upsert($dataUpdateBooks);
    }

    /**
     * Update the status of a book in an order.
     *
     * @param Book $book The book to update.
     * 
     * @param array $data The data containing the new status and note.
     *
     * @return bool
     */
    private function updateStatusBookInOrder(Book $book, array $data): bool
    {
        // If status is the same, do nothing
        if ($data['status'] === OrderDetail::STATUS_MISSING && $data['status'] !== $book->pivot->status) {
            // If book is missing, update with note
            return $this->orderRepository->updateStatusBookInOrderWithNote($book, $data['note']);
        } else if ($data['status'] === OrderDetail::STATUS_RETURNED && $data['status'] !== $book->pivot->status) {
            return $this->orderRepository->updateStatusBookInOrder($book, $data);
        } else {
            return false;
        }
    }
}
