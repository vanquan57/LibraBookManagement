import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/config/constant.dart';
import 'package:mobile/core/helper/error_parser.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/share/data/models/author/author.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

@lazySingleton
class AuthorRemoteDataSource {  
  final Dio _dio;

  AuthorRemoteDataSource(this._dio);

  /// Get list of authors
  ///
  /// @param {number} limit - The limit number
  ///
  /// @return Future<ApiResponse<Paginated<Author>>>
  Future<ApiResponse<Paginated<Author>>> getAuthors({
    required int limit,
  }) async {
    try {
      final response = await _dio.get(
        '/authors',
        queryParameters: {
          'limit': limit, 
          'page': 1,
        },
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => Paginated<Author>.fromJson(
          json as Map<String, dynamic>,
          (json) => Author.fromJson(json as Map<String, dynamic>),
        ),
      );
    } on DioException catch (e) {
      log.e('Get list of authors failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Get list of authors failed: $e');
      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }
}
