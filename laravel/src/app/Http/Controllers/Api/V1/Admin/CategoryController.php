<?php

namespace App\Http\Controllers\Api\V1\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\StoreUpdateCategoryRequest;
use App\Http\Requests\Admin\CategorySearchRequest;
use App\Http\Services\CategoryService;
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

    /**
     * Store a newly created resource in storage.
     *
     * @param StoreUpdateCategoryRequest $request
     *
     * @return JsonResponse
     */
    public function store(StoreUpdateCategoryRequest $request): JsonResponse
    {
        if (!$category = $this->categoryService->store($request->validated())) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau.'
            );
        }
        
        return responseOkAPI($category, Response::HTTP_CREATED);
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
        if (!$category = $this->categoryService->show($id)) {
            return responseErrorAPI(
                Response::HTTP_NOT_FOUND,
                ERROR_CODE_NOT_FOUND,
                'Danh mục không tồn tại.'
            );
        }
        
        return responseOkAPI($category);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param StoreUpdateCategoryRequest $request
     *
     * @param int $id
     *
     * @return JsonResponse
     */
    public function update(StoreUpdateCategoryRequest $request, int $id): JsonResponse
    {
        if (!$this->categoryService->update($request->validated(), $id)) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau.'
            );
        }
        
        return responseOkAPI([
            'message' => 'Cập nhật danh mục thành công.'
        ]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     *
     * @return JsonResponse
     */
    public function destroy(int $id)
    {
        if (!$this->categoryService->destroy($id)) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Danh mục có sách đăng ký, không thể xóa.'
            );
        }
        
        return responseOkAPI(['message' => 'Xóa danh mục thành công.']);
    }
}
