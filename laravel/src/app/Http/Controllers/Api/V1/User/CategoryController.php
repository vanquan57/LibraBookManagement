<?php

namespace App\Http\Controllers\Api\V1\User;

use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\CategorySearchRequest;
use App\Http\Services\User\CategoryService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

class CategoryController extends Controller
{
    /**
     * Constructor
     *
     * @param CategoryService $categoryService
     */
    public function __construct(
        protected CategoryService $categoryService
    ) {}

    /**
     * Display a listing of the resource.
     *
     * @return JsonResponse
     */
    public function index(CategorySearchRequest $request): JsonResponse
    {
        if (!$categories = $this->categoryService->getAllByPagination($request->validated())) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau.'
            );
        }

        return responseOkAPI($categories);
    }
}
