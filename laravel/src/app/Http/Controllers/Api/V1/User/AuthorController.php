<?php

namespace App\Http\Controllers\Api\V1\User;

use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\AuthorSearchRequest;
use App\Http\Services\User\AuthorService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

class AuthorController extends Controller
{
    /**
     * Constructor
     *
     * @param AuthorService $authorService
     *
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
}
