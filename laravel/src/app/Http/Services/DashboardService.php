<?php

namespace App\Http\Services;

use App\Http\Repositories\BookRepositoryInterface;
use App\Http\Repositories\CategoryRepositoryInterface;
use App\Http\Repositories\OrderRepositoryInterface;
use App\Http\Repositories\UserRepositoryInterface;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Support\Facades\Log;
use Carbon\Carbon;
use Carbon\CarbonPeriod;

class DashboardService
{
    /**
     * Constructor
     *
     * @param UserRepositoryInterface $dashboardRepository
     * 
     * @param BookRepositoryInterface $bookRepository
     * 
     * @param OrderRepositoryInterface $orderRepository
     * 
     * @param CategoryRepositoryInterface $categoryRepository
     */
    public function __construct(
        protected UserRepositoryInterface $userRepository,
        protected BookRepositoryInterface $bookRepository,
        protected OrderRepositoryInterface $orderRepository,
        protected CategoryRepositoryInterface $categoryRepository,
    ) {}

    /**
     * Get top user most orders
     * 
     * @param array $data
     * 
     * @return Collection|null
     */
    public function getTopUsersMostOder(array $data): ?Collection
    {
        $data = [
            'limit' => $data['limit'] ?? config('constants.DEFAULT_USER_BORROW_LIMIT'),
            'order_by_type' => $data['order_by_type'] ?? 'desc',
        ];

        try {
            return $this->userRepository->getTopUsersMostOder($data);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * Get top books most popular
     * 
     * @param array $data
     *
     * @return Collection|null
     */
    public function getTopBooksMostPopular(array $data): ?Collection
    {
        $data = [
            'limit' => $data['limit'] ?? config('constants.DEFAULT_BOOK_BORROW_LIMIT'),
            'order_by_type' => $data['order_by_type'] ?? 'desc',
        ];

        try {
            return $this->bookRepository->getTopBooksMostPopular($data);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * Get data total orders by month
     * 
     * @return array|null
     */
    public function getTotalOrdersByMonth(): ?array
    {
        try {
            $results = [];
            $startMonth = Carbon::now()->subMonths(11)->startOfMonth();
            $currentMonth = Carbon::now();
            $period = CarbonPeriod::create($startMonth, '1 month', $currentMonth);
            
            $totalOrdersByMonthAndYear  = $this->orderRepository->getTotalOrdersByMonthAndYear($startMonth, $currentMonth);

            if(!$totalOrdersByMonthAndYear) {
                return null;
            }
            
            foreach ($period as $monthYear) {
                $monthYearFormatted = $monthYear->format('m-Y');

                $results[] = [
                    'month_year' => $monthYearFormatted,
                    'total_orders' => $totalOrdersByMonthAndYear[$monthYearFormatted] ?? 0,
                ];
            }

            return $results;
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * Get data for pie chart categories
     * 
     * @return Collection|null
     */
    public function getTotalBooksInCategories(): ?Collection
    {
        try {
            return $this->categoryRepository->getTotalBooksInCategories();
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * Get data for line chart top books most likely
     * 
     * @param array $data
     * 
     * @return Collection|null
     */
    public function getTopMostLikesBook($data): ?Collection
    {
        $data = [
            'limit' => $data['limit'] ?? config('constants.DEFAULT_BOOK_WISH_LIST_LIMIT'),
            'order_by_type' => $data['order_by_type'] ?? 'desc',
        ];

        try {
            return $this->bookRepository->getTopMostLikesBook($data);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }
}
