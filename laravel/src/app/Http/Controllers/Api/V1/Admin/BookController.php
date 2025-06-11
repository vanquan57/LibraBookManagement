<?php

namespace App\Http\Controllers\Api\V1\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\BookSearchRequest;
use App\Http\Requests\Admin\StoreBookRequest;
use App\Http\Requests\Admin\UpdateBookRequest;
use App\Http\Services\BookService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

class BookController extends Controller
{
    /**
     * The constructor method
     *
     * @param BookService $bookService
     */
    public function __construct(
        protected BookService $bookService,
    ) {}

    /**
     * Display a listing of the resource.
     * 
     * @param BookSearchRequest $request
     *
     * @return JsonResponse
     */
    public function index(BookSearchRequest $request): JsonResponse
    {
        if (!$books = $this->bookService->getAllByPagination($request->validated())) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                Response::HTTP_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau.'
            );
        }
        
        return responseOkAPI($books);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param StoreBookRequest $request
     *
     * @return JsonResponse
     */
    public function store(StoreBookRequest $request): JsonResponse
    {
        if (!$book = $this->bookService->store($request->validated())) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                Response::HTTP_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau.'
            );
        }
        
        return responseOkAPI($book, Response::HTTP_CREATED);
    }

    /**
     * Display the specified resource.
     *
     * @param int id
     *
     * @return JsonResponse
     */
    public function show(int $id): JsonResponse
    {
        if (!$book = $this->bookService->show($id)) {
            return responseErrorAPI(
                Response::HTTP_NOT_FOUND,
                Response::HTTP_NOT_FOUND,
                'Không tìm thấy sách.'
            );
        }
        
        return responseOkAPI($book);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param UpdateBookRequest $request
     *
     * @param int $id
     *
     * @return JsonResponse
     */
    public function update(UpdateBookRequest $request, int $id): JsonResponse
    {
        if (!$this->bookService->update($request->validated(), $id)) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                Response::HTTP_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau.'
            );
        }
        
        return responseOkAPI([
            'message' => 'Cập nhật sách thành công.'
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
        if (!$this->bookService->destroy($id)) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Sách đang được mượn, không thể xóa.'
            );
        }

        return responseOkAPI([
            'message' => 'Xóa sách thành công.'
        ]);
    }
}
