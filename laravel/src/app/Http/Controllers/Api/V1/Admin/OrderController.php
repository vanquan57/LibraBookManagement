<?php

namespace App\Http\Controllers\Api\V1\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\UpdateOrderRequest;
use App\Http\Requests\Admin\OrderSearchRequest;
use App\Http\Services\OrderService;
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
                Response::HTTP_NOT_FOUND,
                Response::HTTP_NOT_FOUND,
                'Không tìm thấy đơn mượn sách.'
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
                'Không thể xử lý yêu cầu, vui lòng thử lại sau.'
            );
        }

        return responseOkAPI([
            'message' => 'Cập nhật đơn mượn sách thành công.'
        ]);
    }
}
