<?php

namespace App\Http\Repositories;

interface OrderDetailsRepositoryInterface extends BaseRepositoryInterface
{
    /**
     * Update status multiple book in order
     * 
     * @param array $IdsOverdueDetails
     * 
     * @return bool
    */
    public function updateStatusMultipleBookOverdueInOrder(array $IdsOverdueDetails): bool;

    /**
     * Insert multiple records to the cart
     * 
     * @param array $data
     * 
     * @return bool
    */
    public function insert(array $data): bool;
}
