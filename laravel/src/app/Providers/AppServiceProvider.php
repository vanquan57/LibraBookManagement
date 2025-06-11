<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Auth\Notifications\VerifyEmail;
use Illuminate\Notifications\Messages\MailMessage;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        VerifyEmail::toMailUsing(function (object $notifiable, string $url) {
            $customUrl = str_replace(env('APP_BACKEND_URL_API_USER'), env('APP_FRONTEND_URL'), $url);

            return (new MailMessage)
                ->subject('Xác thực email')
                ->greeting('Xin chào!')
                ->line('Vui lòng nhấn vào nút bên dưới để xác thực email của bạn.')
                ->action('Xác thực', $customUrl)
                ->line('Nếu bạn gặp vấn đề khi nhấn vào nút "Xác thực", hãy sao chép và dán đường link bên dưới vào trình duyệt của bạn:')
                ->line($customUrl)
                ->salutation('Trân trọng, Laravel');
        });
    }
}
