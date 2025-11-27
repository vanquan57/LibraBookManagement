import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/helper/error_parser.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/core/response/error_default_response.dart';

@lazySingleton
class ProfileRemoteDataSource {
  final Dio _dio;

  ProfileRemoteDataSource(this._dio);

  /// Get user profile
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  Future<ApiResponse<Map<String, dynamic>>> getInformationUser() async {
    try {
      final response = await _dio.get('/profile');

      return ApiResponse<Map<String, dynamic>>.fromJson(
        response.data,
        (data) => data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      log.e('Submit checkout failed: ${getErrorMessage(e)}'); 

      return ApiResponse<Map<String, dynamic>>.fromJson(
        e.response?.data ?? buildErrorResponse("Tiến hành mượn sách thất bại"),
        (data) => data as Map<String, dynamic>,
      );
    } catch (e) {
      log.e('Submit checkout failed w: $e');

      return ApiResponse<Map<String, dynamic>>.fromJson(
        buildErrorResponse("Tiến hành mượn sách thất bại"),
        (data) => data as Map<String, dynamic>,
      );
    }
  }
}
