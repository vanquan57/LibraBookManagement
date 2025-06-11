<?php

namespace App\Http\Controllers\Api\V1\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

class AuthController extends Controller
{
    /**
     * Create a new AuthController instance.
     *
     * @return void
     */
    public function __construct() {}

    /**
     * Get a JWT via given credentials.
     *
     * @param LoginRequest $request
     *
     * @return JsonResponse
     */
    public function login(LoginRequest $request): JsonResponse
    {
        $credentials = $request->only('email', 'password');
        $credentials['role'] = User::ROLE_ADMIN;

        if (!$token = auth('api')->attempt($credentials)) {
            return responseErrorAPI(
                Response::HTTP_UNAUTHORIZED,
                Response::HTTP_UNAUTHORIZED,
                'Email hoặc mật khẩu không chính xác.',
            );
        }

        return responseOkAPI($this->respondWithToken($token));
    }

    /**
     * Log the user out (Invalidate the token).
     *
     * @return JsonResponse
     */
    public function logout(): JsonResponse
    {
        auth('api')->logout();
        auth('api')->invalidate(auth('api')->getToken());

        return responseOkAPI([
            'message' => 'Đăng xuất thành công.'
        ]);
    }

    /**
     * Get the token array structure.
     *
     * @param string $token
     *
     * @return array
     */
    protected function respondWithToken($token): array
    {
        return [
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth('api')->factory()->getTTL() * 60,
        ];
    }
}
