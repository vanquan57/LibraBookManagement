import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/config/constant.dart';
import 'package:mobile/core/helper/error_parser.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/share/data/models/category/category.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

@lazySingleton
class CategoryRemoteDataSource {
  final Dio _dio;

  CategoryRemoteDataSource(this._dio);

  /// Get list of categories
  ///
  /// @param {number} page - The page number
  ///
  /// @return Future<ApiResponse<Paginated<Category>>>
  Future<ApiResponse<Paginated<Category>>> getCategories({
    required int page,
  }) async {
    try {
      final response = await _dio.get(
        '/categories',
        queryParameters: {
          'limit': AppConstants.LIMIT_CATEGORY, 
          'page': page,
        },
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => Paginated<Category>.fromJson(
          json as Map<String, dynamic>,
          (json) => Category.fromJson(json as Map<String, dynamic>),
        ),
      );
    } on DioException catch (e) {
      log.e('Get list of categories failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Get list of categories failed: $e');
      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }
}
