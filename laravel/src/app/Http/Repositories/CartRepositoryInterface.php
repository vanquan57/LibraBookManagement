<?php

namespace App\Http\Repositories;

interface CartRepositoryInterface extends BaseRepositoryInterface
{
    /**
     * Update multiple records to the cart
     * 
     * @param array $data
     * 
     * @return int
    */
    public function upsert(array $items): int;
}
