<?php

use App\Http\Controllers\Api\V1\Admin\AuthController;
use App\Http\Controllers\Api\V1\Admin\EmployeeCodeController;
use App\Http\Controllers\Api\V1\Admin\UserController;
use App\Http\Controllers\Api\V1\Admin\CategoryController;
use App\Models\Category;
use App\Http\Controllers\Api\V1\Admin\AuthorController;
use App\Http\Controllers\Api\V1\Admin\PublisherController;
use App\Http\Controllers\Api\V1\Admin\BookController;
use App\Http\Controllers\Api\V1\Admin\OrderController;
use App\Http\Controllers\Api\V1\Admin\FeedbackController;
use App\Http\Controllers\Api\V1\Admin\DashboardController;
use Illuminate\Support\Facades\Route;

Route::group(['prefix' => 'v1'], function () {
    Route::group(['prefix' => 'admin'], function () {
        Route::group(['prefix' => 'auth'], function () {
            Route::post('login', [AuthController::class, 'login']);
            Route::post('/logout', [AuthController::class, 'logout']);
        });

        Route::group(['middleware' => 'authentication.admin'], function () {
            Route::get('user', [UserController::class, 'index']);
            Route::put('user/{id}', [UserController::class, 'update']);
            Route::get('employees', [EmployeeCodeController::class, 'index']);
            Route::post('employees', [EmployeeCodeController::class, 'store']);
            Route::resource('category', CategoryController::class)->except([
                'create',
                'edit',
            ]);
            Route::resource('author', AuthorController::class)->except([
                'create',
                'edit',
            ]);
            Route::resource('publisher', PublisherController::class)->except([
                'create',
                'edit',
            ]);
            Route::resource('book', BookController::class)->except([
                'create',
                'edit'
            ]);
            Route::group(['prefix' => 'order'], function () {
                Route::get('/', [OrderController::class, 'index']);
                Route::get('/{id}', [OrderController::class, 'show']);
                Route::put('/{id}', [OrderController::class, 'update']);
            });
            Route::resource('/feedback', FeedbackController::class)->only([
                'index',
                'update',
                'destroy'
            ]);
            Route::get('dashboard', [DashboardController::class, 'getDataDashboard']);
        });
    });
});
