<?php

namespace App\Http\Middleware\Admin;

use App\Models\User;
use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Tymon\JWTAuth\Exceptions\TokenExpiredException;
use Tymon\JWTAuth\Exceptions\TokenInvalidException;
use Tymon\JWTAuth\Facades\JWTAuth;

class CheckAdmin
{
    /**
     * Handle an incoming request.
     *
     * @param \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response) $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        try {
            $user = JWTAuth::parseToken()->authenticate();

            if ($user && $user->role === User::ROLE_ADMIN) {
                return $next($request);
            }

            return response()->json([
                'message' => 'You are not authorized to access this route',
            ], Response::HTTP_UNAUTHORIZED);
        } catch (\Exception $e) {
            if ($e instanceof TokenExpiredException) {
                return response()->json(['token_expired' => 'Token has expired'], Response::HTTP_UNAUTHORIZED);
            } elseif ($e instanceof TokenInvalidException) {
                return response()->json(['token_invalid' => 'The token invalid'], Response::HTTP_UNAUTHORIZED);
            } else {
                return response()->json(['error' => 'Token is required'], Response::HTTP_UNAUTHORIZED);
            }
        }
    }
}
