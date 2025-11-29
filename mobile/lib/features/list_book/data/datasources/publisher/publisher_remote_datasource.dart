import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/config/constant.dart';
import 'package:mobile/core/helper/error_parser.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';
import 'package:mobile/share/data/models/publisher/publisher.dart';

@lazySingleton
class PublisherRemoteDataSource {  
  final Dio _dio;

  PublisherRemoteDataSource(this._dio);

  /// Get list of publishers
  ///
  /// @param {number} limit - The limit number
  ///
  /// @return Future<ApiResponse<Paginated<Publisher>>>
  Future<ApiResponse<Paginated<Publisher>>> getPublishers({
    required int limit,
  }) async {
    try {
      final response = await _dio.get(
        '/publishers',
        queryParameters: {
          'limit': limit, 
          'page': 1,
        },
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => Paginated<Publisher>.fromJson(
          json as Map<String, dynamic>,
          (json) => Publisher.fromJson(json as Map<String, dynamic>),
        ),
      );
    } on DioException catch (e) {
      log.e('Get list of publishers failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Get list of publishers failed: $e');
      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }
}
