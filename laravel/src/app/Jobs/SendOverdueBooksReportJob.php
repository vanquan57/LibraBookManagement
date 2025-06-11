<?php

namespace App\Jobs;

use App\Http\Services\BatchService;
use Illuminate\Bus\Batchable;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class SendOverdueBooksReportJob implements ShouldQueue
{
    use Batchable, Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    /**
     * Create a new job instance.
     *
     * @param BatchService $batchService
     */
    public function __construct(
        protected BatchService $batchService
    ) {}

    /**
     * Execute the job.
     */
    public function handle(): void
    {
        try {
            $this->batchService->progressCheckAndUpdateOrderStatus();
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }
}
