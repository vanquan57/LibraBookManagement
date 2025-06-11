<?php

namespace App\Http\Repositories\Eloquent;

use App\Http\Repositories\OrderDetailsRepositoryInterface;
use App\Models\OrderDetail;

class OrderDetailsRepository extends BaseRepository implements OrderDetailsRepositoryInterface
{
    public function getModel(): string
    {
        return OrderDetail::class;
    }
    /**
     * Update status multiple book in order
     * 
     * @param array $IdsOverdueDetails
     * 
     * @return bool
    */
    public function updateStatusMultipleBookOverdueInOrder(array $IdsOverdueDetails): bool
    {
        return $this->model->whereIn("id", $IdsOverdueDetails)->update(["status"=> OrderDetail::STATUS_OVERDUE]);
    }

    /**
     * Insert multiple records to the cart
     * 
     * @param array $data
     * 
     * @return bool
    */
    public function insert(array $data): bool
    {
        return $this->model->insert($data);
    }
}
