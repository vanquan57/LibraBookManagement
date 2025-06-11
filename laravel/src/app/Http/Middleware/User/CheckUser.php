<?php

namespace App\Http\Middleware\User;

use App\Models\User;
use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Tymon\JWTAuth\Exceptions\TokenExpiredException;
use Tymon\JWTAuth\Exceptions\TokenInvalidException;
use Tymon\JWTAuth\Facades\JWTAuth;

class CheckUser
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        try {
            $user = JWTAuth::parseToken()->authenticate();

            if (!$user) {
                return responseErrorAPI(
                    Response::HTTP_UNAUTHORIZED,
                    ERROR_CODE_AUTHENTICATE,
                    'Bạn không có quyền truy cập vào trang web này.'
                );
            }else{
                return $next($request);
            }
        } catch (\Exception $e) {
            if ($e instanceof TokenExpiredException) {
                return responseErrorAPI(
                    Response::HTTP_UNAUTHORIZED,
                    ERROR_CODE_AUTHENTICATE,
                    'Phiên đăng nhập đã hết hạn.'
                );
            } elseif ($e instanceof TokenInvalidException) {
                return responseErrorAPI(
                    Response::HTTP_UNAUTHORIZED,
                    ERROR_CODE_AUTHENTICATE,
                    'Token không hợp lệ, hoặc không đúng định dạng.'
                );
            } else {
                return responseErrorAPI(
                    Response::HTTP_UNAUTHORIZED,
                    ERROR_CODE_AUTHENTICATE,
                    'Token không tồn tại.'
                );
            }
        }
    }
}
