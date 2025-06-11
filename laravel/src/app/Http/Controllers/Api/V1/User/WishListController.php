<?php

namespace App\Http\Controllers\Api\V1\User;

use App\Http\Controllers\Controller;
use App\Http\Requests\User\StoreWishListRequest;
use App\Http\Services\User\WishListService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

class WishListController extends Controller
{
    /**
     * The constructor
     * 
     * @param WishListService $wishListService
     */
    public function __construct(protected WishListService $wishListService) {}

    /**
     * Display a listing my wish list.
     * 
     * @return JsonResponse
     */
    public function index(): JsonResponse
    {
        if (!$wishlists = $this->wishListService->getAll()) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                Response::HTTP_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau.'
            );
        }

        return responseOkAPI($wishlists);
    }

    /**
     * Store a newly created wish list in storage.
     * 
     * @param StoreWishListRequest $request
     * 
     * @return JsonResponse
     */
    public function store(StoreWishListRequest $request): JsonResponse
    {
        $result = $this->wishListService->store($request->validated());

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
     * Remove the specified wish list from storage.
     * 
     * @param int $bookId
     * 
     * @return JsonResponse
     */
    public function destroy(int $bookId): JsonResponse
    {
        if (!$this->wishListService->destroy($bookId)) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                Response::HTTP_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau.'
            );
        }

        return responseOkAPI([
            'message' => 'Đã xóa sách khỏi danh sách yêu thích thành công.'
        ]);
    }
}
