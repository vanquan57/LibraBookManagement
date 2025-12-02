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

  /// Register with name, code, email, password and confirm password
  ///
  /// @param String name
  /// @param String code
  /// @param String email
  /// @param String password
  /// @param String confirmPassword
  /// 
  /// @return Future<ApiResponse<String>>
  Future<ApiResponse<String>> register({
    required String name,
    required String code,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: {
          'name': name,
          'code': code,
          'email': email,
          'password': password,
          'confirm_password': confirmPassword,
        },
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => json['message'] as String,
      );
    } on DioException catch (e) {
      log.e('Register failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Register failed: $e');

      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }

  /// Register with Google account
  ///
  /// @param String accessToken
  /// @param String code
  ///
  /// @return Future<ApiResponse<TokenData>>
  Future<ApiResponse<TokenData>> registerWithGoogle(String accessToken, String code) async {
    try {
      final response = await _dio.post(
        '/auth/google/callback/register',
        data: {'access_token': accessToken, 'code': code},
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

  /// Update password
  ///
  /// @param String currentPassword
  /// @param String newPassword
  /// @param String confirmPassword
  ///
  /// @return ApiResponse<String>
  Future<ApiResponse<String>> updatePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      final response = await _dio.put(
        '/auth/change-password',
        data: {
          'current_password': currentPassword,
          'password': newPassword,
          'confirm_password': confirmPassword,
        },
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => json['message'] as String,
      );
    } on DioException catch (e) {
      log.e('Update password failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Update password failed w: $e');

      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  } 

  /// Logout user
  ///
  /// @return Future<ApiResponse<String>>
  Future<ApiResponse<String>> logout() async {
    try {
      final response = await _dio.post('/auth/logout');
      return ApiResponse.fromJson(
        response.data,
        (json) => json['message'] as String,
      );
    } on DioException catch (e) {
      log.e('Logout failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Logout failed: $e');

      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }

  /// Verify email
  ///
  /// @param String email
  ///
  /// @return Future<ApiResponse<String>>
  Future<ApiResponse<String>> verifyEmail(String email) async {
    try {
      final response = await _dio.post('/auth/verify-email', data: {'email': email});
      
      return ApiResponse.fromJson(
        response.data,
        (json) => json['message'] as String,
      );
    } on DioException catch (e) {
      log.e('Logout failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Logout failed: $e');

      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }

  /// Reset password
  ///
  /// @param String token
  /// @param String email
  /// @param String password
  /// @param String confirmPassword
  ///
  /// @return Future<ApiResponse<String>>
  Future<ApiResponse<String>> resetPassword(
    String token,
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      final response = await _dio.post(
        '/auth/reset-password',
        data: {
          'token': token,
          'email': email,
          'password': password,
          'confirm_password': confirmPassword,
        },
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => json['message'] as String,
      );
    } on DioException catch (e) {
      log.e('Logout failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Logout failed: $e');

      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }
}
