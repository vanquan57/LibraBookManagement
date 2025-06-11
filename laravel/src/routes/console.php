<?php

use App\Jobs\SendOverdueBooksReportJob;
use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Schedule;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote')->hourly();

/**
 * Jobs batching check for overdue books and send a report every day at 8:00 AM
 */
Schedule::job(SendOverdueBooksReportJob::class)->dailyAt('08:00');
