<?php

namespace App\Http\Controllers\Api\V1\User;

use App\Http\Controllers\Controller;
use App\Http\Requests\User\UpdateOrderRequest;
use App\Http\Requests\User\OrderSearchRequest;
use App\Http\Requests\User\StoreOrderRequest;
use App\Http\Services\User\OrderService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

class OrderController extends Controller
{
    /**
     * The constructor
     *
     * @param OrderService $orderService
     */
    public function __construct(
        protected OrderService $orderService
    ) {}

    /**
     * Display a listing of the resource.
     * 
     * @param OrderSearchRequest $request
     *
     * @return JsonResponse
     */
    public function index(OrderSearchRequest $request): JsonResponse
    {
        if (!$orders = $this->orderService->getAllByPaginate($request->validated())) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                Response::HTTP_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau.'
            );
        }

        return responseOkAPI($orders);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param StoreOrderRequest $request
     *
     * @return JsonResponse
     */
    public function store(StoreOrderRequest $request): JsonResponse
    {
        $result = $this->orderService->store($request->validated());

        if ($result['code'] !== Response::HTTP_CREATED) {
            return responseErrorAPI(
                $result['code'],
                $result['error_code'],
                $result['error']
            );
        }

        return responseOkAPI([
            'message' => $result['message']
        ], $result['code']);
    }

    /**
     * Display the specified resource.
     *
     * @param int $id
     *
     * @return JsonResponse
     */
    public function show(int $id): JsonResponse
    {
        if (!$order = $this->orderService->show($id)) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                Response::HTTP_BAD_REQUEST,
                'Đơn hàng không tồn tại vui lòng kiểm tra lại.'
            );
        }

        return responseOkAPI($order);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param UpdateOrderRequest $request
     *
     * @param int $id
     *
     * @return JsonResponse
     */
    public function update(UpdateOrderRequest $request, int $id): JsonResponse
    {
        if (!$this->orderService->update($request->validated(), $id)) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                Response::HTTP_BAD_REQUEST,
                'Không thể xử lý yêu cầu vui lòng thử lại sau.'
            );
        }

        return responseOkAPI([
            'message' => 'Cập nhật đơn mượn thành công',
        ]);
    }
}
