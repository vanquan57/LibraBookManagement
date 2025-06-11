<?php

namespace App\Http\Services;

use App\Http\Repositories\BookRepositoryInterface;
use App\Http\Repositories\FeedbackRepositoryInterface;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Log;

class FeedbackService
{
    /**
     * Constructor
     *
     * @param FeedbackRepositoryInterface $feedbackRepository
     * 
     * @param BookRepositoryInterface $bookRepository
     */
    public function __construct(
        protected FeedbackRepositoryInterface $feedbackRepository,
        protected BookRepositoryInterface $bookRepository
    ) {}

    /**
     * Get all feedbacks by paginate
     *
     * @param array $dataSearch
     * 
     * @return LengthAwarePaginator|null
     */
    public function getAllByPaginate(array $dataSearch): ?LengthAwarePaginator
    {
        try {
            $data = [
                'start_date' => $dataSearch['start_date'] ?? null,
                'end_date' => $dataSearch['end_date'] ?? null,
                'limit' => $dataSearch['limit'] ?? config('constants.DEFAULT_LIMIT'),
                'column' => $dataSearch['column'] ?? null,
                'order' => $dataSearch['order'] ?? null,
            ];

            if(isset($dataSearch['name'])) {
                $bookIds = $this->bookRepository->getIdsByName($dataSearch['name']);
                
                if (empty($bookIds)) {
                    return null;
                }

                $data['book_ids'] = $bookIds;

                return $this->feedbackRepository->getAllByPaginate($data);
            }

            return $this->feedbackRepository->getAllByPaginate($data);
        } catch (\Exception $e) {
            Log::error($e->getMessage());
            
            return null;
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param int $id
     *
     * @return bool
     */
    public function update(int $id): bool
    {
        try {
            return $this->feedbackRepository->updateStatus($id);
        } catch (\Exception $e) {
            Log::error($e->getMessage());
            
            return false;
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     *
     * @return bool
     */
    public function destroy(int $id): bool
    {
        try {
            return $this->feedbackRepository->destroy($id);
        } catch (\Exception $e) {
            Log::error($e->getMessage());
            
            return false;
        }
    }
}
