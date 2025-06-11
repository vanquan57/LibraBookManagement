<?php

namespace App\Http\Controllers\Api\V1\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\StoreUpdatePublisherRequest;
use App\Http\Requests\Admin\PublisherSearchRequest;
use App\Http\Services\PublisherService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

class PublisherController extends Controller
{
    /**
     * Constructor.
     *
     * @param PublisherService $publisherService
     */
    public function __construct(
        protected PublisherService $publisherService
    ) {}

    /**
     * Display a listing of the resource.
     * 
     * @param PublisherSearchRequest $request
     *
     * @return JsonResponse
     */
    public function index(PublisherSearchRequest $request): JsonResponse
    {
        if (!$publishers = $this->publisherService->getAllByPaginate($request->validated())) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau'
            );
        }

        return responseOkAPI($publishers);
    }

    /**
     * Store a newly created resource in storage.
     * 
     * @param StoreUpdatePublisherRequest $request
     * 
     * @return JsonResponse
     */
    public function store(StoreUpdatePublisherRequest $request): JsonResponse
    {
        if (!$publisher = $this->publisherService->store($request->validated())) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau'
            );
        }

        return responseOkAPI($publisher, Response::HTTP_CREATED);
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
        if (!$publisher = $this->publisherService->show($id)) {
            return responseErrorAPI(
                Response::HTTP_NOT_FOUND,
                ERROR_BAD_REQUEST,
                'Nhà xuất bản không tồn tại'
            );
        }

        return responseOkAPI($publisher);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param StoreUpdatePublisherRequest $request
     *
     * @param int $id
     *
     * @return JsonResponse
     */
    public function update(StoreUpdatePublisherRequest $request, int $id): JsonResponse
    {
        if (!$this->publisherService->update($id, $request->validated())) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau'
            );
        }

        return responseOkAPI([
            'message' => 'Cập nhật nhà xuất bản thành công'
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
        if (!$this->publisherService->destroy($id)) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau'
            );
        }

        return responseOkAPI([
            'message' => 'Xóa nhà xuất bản thành công'
        ]);
    }
}
