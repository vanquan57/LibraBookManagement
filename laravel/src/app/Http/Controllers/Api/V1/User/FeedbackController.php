<?php

namespace App\Http\Controllers\Api\V1\User;

use App\Http\Controllers\Controller;
use App\Http\Requests\User\FeedbackSearchRequest;
use App\Http\Requests\User\StoreFeedbackRequest;
use App\Http\Services\User\FeedbackService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

class FeedbackController extends Controller
{
    /**
     * The Constructor
     * 
     * @param FeedbackService $feedbackService
     */
    public function __construct(
        protected FeedbackService $feedbackService
    ) {}

    /**
     * Get feedbacks by book id.
     * 
     * @param FeedbackSearchRequest $request
     * 
     * @return JsonResponse
     */
    public function getFeedbacksByBookId(FeedbackSearchRequest $request): JsonResponse
    {
        if (!$feedbacks = $this->feedbackService->getFeedbacksByBookId($request->validated())) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Không thể xử lý yêu cầu vui lòng thử lại sau'
            );
        }

        return responseOkAPI($feedbacks);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param StoreFeedbackRequest $request
     * 
     * @return JsonResponse
     */
    public function store(StoreFeedbackRequest $request): JsonResponse
    {
        $user = auth('api')->user();

        if (!$this->feedbackService->store($request->validated(), $user)) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Có lỗi xảy ra, vui lòng thử lại sau.'
            );
        }

        return responseOkAPI(
            [
                'message' => 'Gửi phản hồi thành công. Đang chờ xác nhận từ quản trị viên.'
            ],
            Response::HTTP_CREATED
        );
    }
}
