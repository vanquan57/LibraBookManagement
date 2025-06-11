<?php

namespace App\Http\Services;

use App\Http\Repositories\OrderDetailsRepositoryInterface;
use App\Http\Repositories\OrderRepositoryInterface;
use App\Mail\OverdueBooksNotification;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;

class BatchService
{
    /**
     * Constructor
     *
     * @param OrderRepositoryInterface $orderRepository
     */
    public function __construct(
        protected OrderRepositoryInterface $orderRepository,
        protected OrderDetailsRepositoryInterface $orderDetailsRepository
    ) {}

    /**
     * Progress check and update order status
     *
     * @return void
     */
    public function progressCheckAndUpdateOrderStatus()
    {
        try {
            DB::beginTransaction();
            
            $orders = $this->orderRepository->getAllOrderOverdue();

            $idsOrder = [];
            $IdsOverdueDetails = [];

            foreach ($orders as $order) {
                $overdueBooks = [];
    
                foreach ($order->orderDetails as $detail) {
                    $overdueBooks[] = $detail;
                    $IdsOverdueDetails[] = $detail->pivot->id;
                }
    
                if (!empty($overdueBooks)) {
                    $idsOrder[] = $order->id;
    
                    Mail::to($order->email)->queue(new OverdueBooksNotification($order, $overdueBooks));
                }
            }
    
            if (!empty($idsOrder)) {
                if(!$this->orderRepository->updateStatusMultipleOrderIsOverdue($idsOrder)) {
                    throw new \Exception("Cập nhật trạng thái đơn hàng thất bại.");
                }
            }

            if (!empty($IdsOverdueDetails)) {
                if(!$this->orderDetailsRepository->updateStatusMultipleBookOverdueInOrder($IdsOverdueDetails)){
                    throw new \Exception("Cập nhật trạng thái sách trong đơn hàng thất bại.");
                }
            }

            DB::commit();
        } catch (\Exception $e) {
            Log::error($e->getMessage());
            DB::rollBack();
        }
    }
}
