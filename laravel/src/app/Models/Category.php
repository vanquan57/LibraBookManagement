<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class Category extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name',
        'slug',
        'description',
    ];

    /**
     * Mutators for attributes slug
     */
    public function setSlugAttribute($value)
    {
        $this->attributes['slug'] = $this->generateUniqueSlug($value);
    }

    /**
     * Generate a unique slug for a category based on the given title.
     *
     * @param string $title The title of the category.
     * 
     * @return string The unique slug for the category.
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
     * Relationship to the book table
     */
    public function books()
    {
        return $this->belongsToMany(Book::class, 'book_categories')->withTimestamps();
    }
}
