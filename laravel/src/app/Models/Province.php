<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Province extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'code',
        'name',
    ];

    /**
     * Relationship to the district table
     */
    public function districts()
    {
        return $this->hasMany(District::class, 'province_code');
    }

    /**
     * Relationship to the user table
     */
    public function users()
    {
        return $this->hasMany(User::class);
    }

    /**
     * Relationship to the order table
     */
    public function orders()
    {
        return $this->hasMany(Order::class);
    }
}
