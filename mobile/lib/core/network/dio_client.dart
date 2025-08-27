import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile/core/config/env.dart';
import 'package:mobile/core/logger/logger.dart';
import '../storage/local_storage_service.dart';

class DioClient {
  final Dio dio;
  final LocalStorageService _storageService;

  DioClient({required LocalStorageService storageService})
    : _storageService = storageService,
      dio = Dio(
        BaseOptions(
          baseUrl: Env.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      ) {
    _addInterceptors();
  }

  void _addInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        // Auto add Authorization header
        onRequest: (options, handler) async {
          if (!options.path.contains("/auth/login")) {
            final accessToken = await _storageService.getAccessToken();

            if (accessToken != null) {
              options.headers['Authorization'] = 'Bearer $accessToken';
            }
          }

          return handler.next(options); // Continue with the request
        },

        // Handle errors (e.g., token expired)
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            log.e('Token has expired, need to refresh...');
          }
          return handler.next(e);
        },
      ),
    );

    // Add Log Interceptor if in debug mode
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(responseBody: true, requestBody: true),
      );
    }
  }
}
