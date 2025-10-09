import 'package:dio/dio.dart';
import 'package:mobile/core/helper/error_parser.dart';
import 'package:mobile/core/logger/logger.dart';
import '../../../../core/response/api_response.dart';
import '../models/token_data.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  /// Login with email and password
  ///
  /// @param String email
  /// @param String password
  ///
  /// @return Future<ApiResponse<TokenData>>
  Future<ApiResponse<TokenData>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => TokenData.fromJson(json),
      );
    } on DioException catch (e) {
      log.e('Login failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Login failed: $e');

      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }

  /// Login with Google account
  ///
  /// @param String accessToken
  ///
  /// @return Future<ApiResponse<TokenData>>
  Future<ApiResponse<TokenData>> loginWithGoogle(String accessToken) async {
    try {
      final response = await _dio.post(
        '/auth/google/callback',
        data: {'access_token': accessToken},
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => TokenData.fromJson(json),
      );
    } on DioException catch (e) {
      log.e('Login google failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Login google failed: $e');

      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }
}
