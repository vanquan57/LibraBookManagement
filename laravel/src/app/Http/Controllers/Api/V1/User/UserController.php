<?php

namespace App\Http\Controllers\Api\V1\User;

use App\Http\Controllers\Controller;
use App\Http\Requests\User\UpdateInfoRequest;
use App\Http\Services\User\UserService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

class UserController extends Controller
{
    /**
     * The constructor
     *
     * @param UserService $userService
     */
    public function __construct(protected UserService $userService) {}

    /**
     * Display the specified resource.
     *
     * @return Response
     */
    public function show(): JsonResponse
    {
        $user = auth('api')->user();

        if (!$userDetails = $this->userService->show($user->id)) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Có lỗi xảy ra vui lòng thử lại sau'
            );
        }

        return responseOkAPI($userDetails);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param UpdateInfoRequest $request
     *
     * @return JsonResponse
     */
    public function update(UpdateInfoRequest $request): JsonResponse
    {
        $user = auth('api')->user();

        if (!$this->userService->update($request->validated(), $user->id)) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                ERROR_BAD_REQUEST,
                'Có lỗi xảy ra vui lòng thử lại sau'
            );
        }

        return responseOkAPI([
            'message' => 'Cập nhật thông tin thành công'
        ]);
    }
}
