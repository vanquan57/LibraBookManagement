<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;

class Book extends Model
{
    use HasFactory, SoftDeletes;

    const HARD_COVER = 1;
    const SOFT_COVER = 2;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'author_id',
        'publisher_id',
        'name',
        'slug',
        'mini_description',
        'details_description',
        'publication_date',
        'quantity',
        'size',
        'page',
        'cover_type',
        'views',
        'borrowing_number',
        'image',
    ];

    protected $appends = ['average_star'];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'publication_date' => 'date',
    ];

    /**
     * Mutators for attributes slug
     */
    public function setSlugAttribute($value)
    {
        $this->attributes['slug'] = $this->generateUniqueSlug($value);
    }

    /**
     * Generate a unique slug for a book based on the given title.
     *
     * @param string $title The title of the book.
     * 
     * @return string The unique slug for the book.
     */
    private function generateUniqueSlug($title) {
        $slug = Str::slug($title);
        $originalSlug = $slug;
        $count = 1;

        while (self::where('slug', $slug)->exists()) {
            $slug = $originalSlug . '-' . $count;
            $count++;
        }

        return $slug;
    }

    /**
     * Relationship to the author table
     */
    public function author()
    {
        return $this->belongsTo(Author::class);
    }

    /**
     * Relationship to the publisher table
     */
    public function publisher()
    {
        return $this->belongsTo(Publisher::class);
    }

    /**
     * Relationship to the category table
     */
    public function categories()
    {
        return $this->belongsToMany(Category::class, 'book_categories')->withTimestamps();
    }

    /**
     * Relationship to the image table
     */
    public function images()
    {
        return $this->hasMany(Image::class);
    }

    /**
     *  Relationship to the wish_list table
     */
    public function wishLists()
    {
        return $this->belongsToMany(User::class, 'wish_lists')->withTimestamps();
    }

    /**
     * Relationship to the user table
     */
    public function users()
    {
        return $this->belongsToMany(User::class, 'carts')->withPivot('quantity')->withTimestamps();
    }

    /**
     * Relationship to the book_order table
     */
    public function orderDetails()
    {
        return $this->belongsToMany(Order::class, 'order_details')->withPivot(
            'id',
            'borrow_date',
            'return_date',
            'quantity',
            'note',
            'status'
        )->withTimestamps();
    }

    /**
     * Relationship to the review table
     */
    public function feedbacks()
    {
        return $this->belongsToMany(User::class, 'feedbacks')->withPivot(
            'content',
            'star',
            'status'
        )->withTimestamps();
    }

    /**
     * The method averages the star and returns it as an integer
     */
    public function getAverageStarAttribute()
    {
        return (int) round($this->feedbacks()->avg('star'));
    }
}
