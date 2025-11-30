import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/helper/error_parser.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/profile/domain/usecase/profile/update_profile.dart';
import 'package:mobile/share/data/models/user/user.dart';

@lazySingleton
class ProfileRemoteDataSource {
  final Dio _dio;

  ProfileRemoteDataSource(this._dio);

  /// Get user profile
  ///
  /// @return ApiResponse<User>
  Future<ApiResponse<User>> getInformationUser() async {
    try {
      final response = await _dio.get('/profile');

      return ApiResponse<User>.fromJson(
        response.data,
        (data) => User.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      log.e('Submit checkout failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Submit checkout failed w: $e');

      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }

  /// Update user profile
  ///
  /// @param UpdateProfileParam params
  ///
  /// @return ApiResponse<String>
  Future<ApiResponse<String>> updateProfile(UpdateProfileParam params) async {
    try {
      final response = await _dio.put('/profile', data: params.toJson());

      return ApiResponse.fromJson(
        response.data,
        (json) => json['message'] as String,
      );
    } on DioException catch (e) {
      log.e('Update user profile failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Update user profile failed w: $e');

      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }
}
