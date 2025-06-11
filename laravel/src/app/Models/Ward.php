<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ward extends Model
{
    use HasFactory;

    protected $fillable = [
        'code',
        'district_code',
        'name',
    ];

    /**
     * Relationship to the district table
     */
    public function district()
    {
        return $this->belongsTo(District::class, 'district_code');
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
