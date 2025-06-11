<?php

namespace App\Models;

use App\Notifications\ResetPasswordNotification;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Tymon\JWTAuth\Contracts\JWTSubject;

class User extends Authenticatable implements JWTSubject, MustVerifyEmail
{
    /** @use HasFactory<\Database\Factories\UserFactory> */
    use HasFactory, Notifiable, SoftDeletes;

    const ROLE_USER = 0;

    const ROLE_ADMIN = 1;

    const STATUS_WAITING = 1;

    const STATUS_ACTIVE = 2;

    const STATUS_BLOCK = 3;

    const GROUP_STATUS = [
        self::STATUS_WAITING,
        self::STATUS_ACTIVE,
        self::STATUS_BLOCK,
    ];

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'code',
        'name',
        'email',
        'password',
        'role',
        'google_id',
        'avatar',
        'province_id',
        'district_id',
        'ward_id',
        'address',
        'status',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    /**
     * Relationship to the book model
     */
    public function books()
    {
        return $this->belongsToMany(Book::class, 'carts')->withPivot('quantity')->withTimestamps();
    }

    /**
     * Relationship to the WishList model
     */
    public function wishLists()
    {
        return $this->belongsToMany(Book::class, 'wish_lists')->withTimestamps();
    }

    /**
     * Relationship to the order model
     */
    public function orders()
    {
        return $this->hasMany(Order::class);
    }

    /**
     * Relationship to the feedback table
     */
    public function feedbacks()
    {
        return $this->belongsToMany(Book::class, 'feedbacks')->withPivot(
            'content',
            'star',
            'status'
        )->withTimestamps();
    }

    /**
     * Relationship to the province model
     */
    public function province()
    {
        return $this->belongsTo(Province::class);
    }

    /**
     * Relationship to the district model
     */
    public function district()
    {
        return $this->belongsTo(District::class);
    }

    /**
     * Relationship to the ward model
     */
    public function ward()
    {
        return $this->belongsTo(Ward::class);
    }

    /**
     * Get the identifier that will be stored in the subject claim of the JWT.
     *
     * @return mixed
     */
    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    /**
     * Return a key value array, containing any custom claims to be added to the JWT.
     *
     * @return array
     */
    public function getJWTCustomClaims()
    {
        return [];
    }

    /**
     * Send the password reset notification to the user.
     *
     * @param string $token
     *
     * @return void
     */
    public function sendPasswordResetNotification($token)
    {
        $this->notify(new ResetPasswordNotification(
            env('APP_FRONTEND_URL') . '/auth/password/reset/?token=' . $token .
                '&email=' . urlencode($this->email)
        ));
    }
}
