<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class OrderDetail extends Model
{
    use HasFactory, SoftDeletes;

    /**
     * OrderDetail status column.
     *
     * These constants represent the various statuses that an order detail can have.
     *
     * STATUS_OVERDUE: The order detail is overdue.
     * STATUS_BORROWING: The order detail is currently being borrowed.
     * STATUS_MISSING: The order detail is missing.
     * STATUS_RETURNED: The order detail has been returned.
     */
    const STATUS_OVERDUE = 1;

    const STATUS_BORROWING = 2;

    const STATUS_MISSING = 3;

    const STATUS_RETURNED = 4;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'order_id',
        'book_id',
        'borrow_date',
        'return_date',
        'quantity',
        'note',
        'status',
    ];

    /**
     * Relationship to the order table
     */
    public function order()
    {
        return $this->belongsTo(Order::class, 'order_id');
    }

    /**
     * Relationship to the book table
     */
    public function book()
    {
        return $this->belongsTo(Book::class, 'book_id');
    }
}
