<?php

namespace App\Providers;

use App\Http\Repositories\Eloquent\ProvinceRepository;
use App\Http\Repositories\ProvinceRepositoryInterface;
use Illuminate\Support\ServiceProvider;

class ProvinceServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     */
    public function register(): void
    {
        $this->app->bind(
            ProvinceRepositoryInterface::class,
            ProvinceRepository::class
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
