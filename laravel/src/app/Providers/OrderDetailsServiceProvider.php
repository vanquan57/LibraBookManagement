<?php

namespace App\Providers;

use App\Http\Repositories\Eloquent\OrderDetailsRepository;
use App\Http\Repositories\OrderDetailsRepositoryInterface;
use Illuminate\Support\ServiceProvider;

class OrderDetailsServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     */
    public function register(): void
    {
        $this->app->bind(
            OrderDetailsRepositoryInterface::class,
            OrderDetailsRepository::class
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
