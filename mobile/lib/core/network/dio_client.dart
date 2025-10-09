// lib/core/network/dio_client.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/config/env.dart';
import 'package:mobile/core/logger/logger.dart';
import '../storage/local_storage_service.dart';

@lazySingleton
class DioClient {
  final Dio dio;
  final LocalStorageService _storageService;
  
  // SYNC constructor injection
  DioClient(this._storageService)
    : dio = Dio(
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
        onRequest: (options, handler) async {
          if (!options.path.contains("/auth/login")) {
            final accessToken = await _storageService.getAccessToken();

            if (accessToken != null) {
              options.headers['Authorization'] = 'Bearer $accessToken';
            }
          }

          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            log.e('Token has expired, need to refresh...');
          }
          return handler.next(e);
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(responseBody: true, requestBody: true),
      );
    }
  }
}

// Module to provide Dio instance
@module
abstract class DioModule {
  @lazySingleton
  Dio provideDio(DioClient dioClient) => dioClient.dio;
}
