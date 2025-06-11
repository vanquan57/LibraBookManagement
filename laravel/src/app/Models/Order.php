<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    use HasFactory;

    /**
     * Order status column.
     *
     * STATUS_OVERDUE: The order status is overdue.
     * STATUS_BORROWING: The order status is currently being borrowed.
     * STATUS_MISSING: The order status is missing.
     * STATUS_RETURNED: The order status has been returned.
     */
    const STATUS_OVERDUE = 1;

    const STATUS_BORROWING = 2;

    const STATUS_MISSING = 3;

    const STATUS_RETURNED = 4;

    const GROUP_STATUS = [
        self::STATUS_OVERDUE,
        self::STATUS_BORROWING,
        self::STATUS_MISSING,
        self::STATUS_RETURNED,
    ];

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'user_id',
        'code',
        'phone',
        'email',
        'province_id',
        'district_id',
        'ward_id',
        'address',
        'status',
    ];

    /**
     * Relationship to the user table
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Relationship to the province table
     */
    public function province()
    {
        return $this->belongsTo(Province::class);
    }

    /**
     * Relationship to the district table
     */
    public function district()
    {
        return $this->belongsTo(District::class);
    }

    /**
     * Relationship to the ward table
     */
    public function ward()
    {
        return $this->belongsTo(Ward::class);
    }

    /**
     * Relationship to the order_details table
     */
    public function orderDetails()
    {
        return $this->belongsToMany(Book::class, 'order_details')->withPivot(
            'id',
            'borrow_date',
            'return_date',
            'quantity',
            'note',
            'status'
        )->withTimestamps();
    }
}
