<?php

namespace App\Providers;

use App\Http\Repositories\DistrictRepositoryInterface;
use App\Http\Repositories\Eloquent\DistrictRepository;
use Illuminate\Support\ServiceProvider;

class DistrictServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     */
    public function register(): void
    {
        $this->app->bind(
            DistrictRepositoryInterface::class,
            DistrictRepository::class
        );
    }

    /**
     * Bootstrap services.
     */
    public function boot(): void
    {
        //
    }
}
