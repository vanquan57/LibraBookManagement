<?php

namespace App\Http\Controllers\Api\V1\User;

use App\Http\Controllers\Controller;
use App\Http\Requests\User\StoreUpdateCartRequest;
use App\Http\Services\User\CartService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

class CartController extends Controller
{
    /**
     * The constructor
     * 
     * @param CartService $cartService
     */
    public function __construct(
        protected CartService $cartService
    ) {}

    /**
     * Get book in my cart
     *
     * @return JsonResponse
     */
    public function index(): JsonResponse
    {
        if (!$bookInCart = $this->cartService->getAllBookInCart()) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                Response::HTTP_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau.'
            );
        }

        return responseOkAPI($bookInCart);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param StoreUpdateCartRequest $request
     *
     * @return JsonResponse
     */
    public function store(StoreUpdateCartRequest $request): JsonResponse
    {
        $result = $this->cartService->store($request->all());

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
     * Update the specified resource in storage.
     *
     * @param StoreUpdateCartRequest $request
     * 
     * @return JsonResponse
     */
    public function update(StoreUpdateCartRequest $request): JsonResponse
    {
        $result = $this->cartService->update($request->validated());

        if ($result['code'] !== Response::HTTP_OK) {
            return responseErrorAPI(
                $result['code'],
                $result['error_code'],
                $result['error']
            );
        }

        return responseOkAPI([
            'message' => $result['message']
        ]);
    }


    /**
     * Remove the specified resource from storage.
     *
     * @param int $bookId
     *
     * @return JsonResponse
     */
    public function destroy(int $bookId): JsonResponse
    {
        if (!$this->cartService->destroy($bookId)) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                Response::HTTP_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau.'
            );
        }

        return responseOkAPI([
            'message' => 'Đã xóa sách khỏi giỏ mượn thành công.'
        ]);
    }
}
