import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/helper/error_parser.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/share/data/models/ward/ward.dart';

@lazySingleton
class WardRemoteDataSource {
  final Dio _dio;

  WardRemoteDataSource(this._dio);

  /// Get list of districts
  ///
  /// @param String districtCode
  ///
  /// @return ApiResponse<List<Ward>>
  Future<ApiResponse<List<Ward>>> getWards(String districtCode) async {
    try {
      final response = await _dio.get('/wards/${districtCode}');

      return ApiResponse<List<Ward>>.fromJson(
        response.data,
        (data) => (data as List).map((item) => Ward.fromJson(item)).toList(),
      );
    } on DioException catch (e) {
      log.e('Get list of wards failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Get list of wards failed: $e');

      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }
}
