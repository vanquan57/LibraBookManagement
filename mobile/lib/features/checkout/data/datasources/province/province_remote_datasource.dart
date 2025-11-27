import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/helper/error_parser.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/share/data/models/province/province.dart';

@lazySingleton
class ProvinceRemoteDataSource {
  final Dio _dio;

  ProvinceRemoteDataSource(this._dio);

  /// Get list of districts
  ///
  /// @param int provinceId
  ///
  /// @return ApiResponse<List<Province>>
  Future<ApiResponse<List<Province>>> getProvinces() async {
    try {
      final response = await _dio.get(
        '/provinces',
      );

      return ApiResponse<List<Province>>.fromJson(
        response.data,
        (data) => (data as List).map((item) => Province.fromJson(item)).toList(),
      );
    } on DioException catch (e) {
      log.e('Get list of provinces failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Get list of provinces failed: $e');

      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }
}
