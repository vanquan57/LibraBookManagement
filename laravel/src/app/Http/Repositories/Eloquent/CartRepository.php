<?php

namespace App\Http\Repositories\Eloquent;

use App\Http\Repositories\CartRepositoryInterface;
use App\Models\Cart;

class CartRepository extends BaseRepository implements CartRepositoryInterface
{
    public function getModel(): string
    {
        return Cart::class;
    }

    /**
     * Create or update multiple records to the cart
     * 
     * @param array $data
     * 
     * @return int
     */
    public function upsert(array $data): int
    {
        return $this->model->upsert(
            $data,
            [
                'user_id',
                'book_id'
            ],
            [
                'quantity',
                'updated_at'
            ]
        );
    }
}
