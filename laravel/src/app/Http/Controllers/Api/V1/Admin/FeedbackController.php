<?php

namespace App\Http\Controllers\Api\V1\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\FeedbackSearchRequest;
use App\Http\Services\FeedbackService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

class FeedbackController extends Controller
{
    /**
     * Constructor
     *
     * @param FeedbackService $feedbackService
     */
    public function __construct(protected FeedbackService $feedbackService) {}

    /**
     * Display a listing of the resource.
     * 
     * @param FeedbackSearchRequest $request
     *
     * @return JsonResponse
     */
    public function index(FeedbackSearchRequest $request): JsonResponse
    {
        if(!$feedbacks = $this->feedbackService->getAllByPaginate($request->validated())) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                Response::HTTP_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau.'
            );
        }

        return responseOkAPI($feedbacks);
    }

    /**
     * Update status of the feedback
     *
     * @param int $id
     *
     * @return JsonResponse
     */
    public function update(int $id): JsonResponse
    {
        if(!$this->feedbackService->update($id)){
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                Response::HTTP_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau.'
            );
        }

        return responseOkAPI([
            'message' => 'Cập nhật trạng thái phản hồi thành công.'
        ]);
    }

    /**
     * Remove the feedback
     *
     * @param int $id
     *
     * @return JsonResponse
     */
    public function destroy(int $id): JsonResponse
    {
        if(!$this->feedbackService->destroy($id)){
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau.'
            );
        }

        return responseOkAPI([
            'message' => 'Xóa phản hồi thành công.'
        ]);
    }
}
