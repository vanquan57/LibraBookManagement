<?php

namespace App\Providers;

use App\Http\Repositories\Eloquent\WardRepository;
use App\Http\Repositories\WardRepositoryInterface;
use Illuminate\Support\ServiceProvider;

class WardServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     */
    public function register(): void
    {
        $this->app->bind(
            WardRepositoryInterface::class,
            WardRepository::class
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
