<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class District extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'code',
        'province_code',
        'name',
    ];

    /**
     * Relationship to the province table
     */
    public function province()
    {
        return $this->belongsTo(Province::class, 'province_code');
    }

    /**
     * Relationship to the ward table
     */
    public function wards()
    {
        return $this->hasMany(Ward::class, 'district_code');
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
