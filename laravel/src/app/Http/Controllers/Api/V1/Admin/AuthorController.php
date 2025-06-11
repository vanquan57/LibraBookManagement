<?php

namespace App\Http\Controllers\Api\V1\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\StoreUpdateAuthorRequest;
use App\Http\Requests\Admin\AuthorSearchRequest;
use App\Http\Services\AuthorService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

class AuthorController extends Controller
{
    /**
     * Constructor
     *
     * @param AuthorService $authorService
     */
    public function __construct(
        protected AuthorService $authorService
    ) {}

    /**
     * Display a listing of the resource.
     *
     * @param AuthorSearchRequest $request
     *
     * @return JsonResponse
     */
    public function index(AuthorSearchRequest $request): JsonResponse
    {
        if (!$authors = $this->authorService->getAllByPaginate($request->validated())) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau'
            );
        }

        return responseOkAPI($authors);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param StoreUpdateAuthorRequest $request
     *
     * @return JsonResponse
     */
    public function store(StoreUpdateAuthorRequest $request): JsonResponse
    {
        if (!$author = $this->authorService->store($request->validated())) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau'
            );
        }

        return responseOkAPI($author, Response::HTTP_CREATED);
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
        if (!$author = $this->authorService->show($id)) {
            return responseErrorAPI(
                Response::HTTP_NOT_FOUND,
                ERROR_CODE_NOT_FOUND,
                'Không tìm thấy tác giả'
            );
        }

        return responseOkAPI($author);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param StoreUpdateAuthorRequest $request
     *
     * @param int $id
     *
     * @return JsonResponse
     */
    public function update(StoreUpdateAuthorRequest $request, int $id): JsonResponse
    {
        if (!$this->authorService->update($id, $request->validated())) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau'
            );
        }

        return responseOkAPI([
            'message' => 'Cập nhật tác giả thành công'
        ]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     *
     * @return JsonResponse
     */
    public function destroy(int $id): JsonResponse
    {
        if (!$this->authorService->destroy($id)) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Tác giả có sách đăng ký, không thể xóa.'
            );
        }

        return responseOkAPI([
            'message' => 'Xóa tác giả thành công.'
        ]);
    }
}
