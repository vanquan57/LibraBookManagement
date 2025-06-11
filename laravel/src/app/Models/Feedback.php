<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Feedback extends Model
{
    use HasFactory;

    protected $table = 'feedbacks';

    /**
     * Class Feedback
     *
     * This class represents the Feedback model.
     *
     * Constants:
     * - STATUS_WAITING: Indicates that the feedback is in a waiting status.
     * - STATUS_ACTIVE: Indicates that the feedback is in an active status.
     */
    const STATUS_WAITING = 0;

    const STATUS_ACTIVE = 1;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'user_id',
        'book_id',
        'parent_id',
        'content',
        'star',
        'status',
    ];

    /**
     * Relationship to the user table
     */
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    /**
     * Relationship to the book table
     */
    public function book()
    {
        return $this->belongsTo(Book::class, 'book_id');
    }

    /**
     * Relationship to the feedback table
     */
    public function children()
    {
        return $this->hasMany(Feedback::class, 'parent_id');
    }
}
