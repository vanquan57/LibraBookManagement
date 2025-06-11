<?php

namespace App\Providers;

use App\Http\Repositories\Eloquent\FeedbackRepository;
use App\Http\Repositories\FeedbackRepositoryInterface;
use Illuminate\Support\ServiceProvider;

class FeedbackServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     */
    public function register(): void
    {
        $this->app->bind(
            FeedbackRepositoryInterface::class,
            FeedbackRepository::class
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
