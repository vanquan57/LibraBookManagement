<?php

namespace App\Providers;

use App\Http\Repositories\Eloquent\PublisherRepository;
use App\Http\Repositories\PublisherRepositoryInterface;
use Illuminate\Support\ServiceProvider;

class PublisherServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     */
    public function register(): void
    {
        $this->app->bind(
            PublisherRepositoryInterface::class,
            PublisherRepository::class
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
