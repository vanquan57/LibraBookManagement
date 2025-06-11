<?php

namespace App\Http\Controllers\Api\V1\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\UpdateStatusUserRequest;
use App\Http\Requests\Admin\UserSearchRequest;
use App\Http\Services\UserService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

class UserController extends Controller
{
    /**
     * Constructor
     *
     * @param UserService $userService
     */
    public function __construct(
        protected UserService $userService
    ) {}

    /**
     * Display a listing of the resource.
     *
     * @param UserSearchRequest $request
     *
     * @return JsonResponse
     */
    public function index(UserSearchRequest $request): JsonResponse
    {
        if (!$users = $this->userService->getAllByPagination($request->validated())) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau.'
            );
        }
        
        return responseOkAPI($users);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param UpdateStatusUserRequest $request
     *
     * @param int $id
     *
     * @return JsonResponse
     */
    public function update(UpdateStatusUserRequest $request, int $id): JsonResponse
    {
        if (!$this->userService->updateStatus($request->validated(), $id)) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Cập nhật trạng thái thất bại.'
            );
        }
        
        return responseOkAPI([
            'message' => 'Cập nhật trạng thái người dùng thành công.'
        ]);
    }
}
