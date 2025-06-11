<?php

namespace App\Providers;

use App\Http\Repositories\Eloquent\EmployeeCodeRepository;
use App\Http\Repositories\EmployeeCodeRepositoryInterface;
use Illuminate\Support\ServiceProvider;

class EmployeeCodeServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     */
    public function register(): void
    {
        $this->app->bind(
            EmployeeCodeRepositoryInterface::class,
            EmployeeCodeRepository::class
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
