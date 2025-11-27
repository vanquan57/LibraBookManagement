import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/helper/error_parser.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/share/data/models/district/district.dart';

@lazySingleton
class DistrictRemoteDataSource {
  final Dio _dio;

  DistrictRemoteDataSource(this._dio);

  /// Get list of districts
  ///
  /// @param String provinceCode
  ///
  /// @return ApiResponse<List<District>>
  Future<ApiResponse<List<District>>> getDistricts(String provinceCode) async {
    try {
      final response = await _dio.get(
        '/districts/${provinceCode}',
      );

      return ApiResponse<List<District>>.fromJson(
        response.data,
        (data) => (data as List).map((item) => District.fromJson(item)).toList(),
      );
    } on DioException catch (e) {
      log.e('Get list of districts failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Get list of districts failed: $e');

      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }
}
