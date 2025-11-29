import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/helper/error_parser.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/share/data/models/book/book.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

@lazySingleton
class BookRemoteDataSource {
  final Dio _dio;

  BookRemoteDataSource(this._dio);

  /// Get book details by book ID.
  ///
  /// @param int bookId
  ///
  /// @return Future<ApiResponse<Book>>
  Future<ApiResponse<Book>> getBookDetails(int bookId) async {
    try {
      final queryParameters = <String, dynamic>{};

      final response = await _dio.get(
        '/book/$bookId',
        queryParameters: queryParameters,
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => Book.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      log.e('Get book details failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Get book details failed: $e');

      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }

  /// Get book same category by category ID.
  ///
  /// @param int categoryId
  /// @param int limit
  ///
  /// @return Future<ApiResponse<Paginated<Book>>>
  Future<ApiResponse<Paginated<Book>>> getBookSameCategory(
    int categoryId,
    int limit,
  ) async {
    try {
      final queryParameters = <String, dynamic>{};

      queryParameters['page'] = 1;
      queryParameters['limit'] = limit;
      queryParameters['category_id'] = categoryId;

      final response = await _dio.get(
        '/book',
        queryParameters: queryParameters,
        options: Options(listFormat: ListFormat.multiCompatible),
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => Paginated<Book>.fromJson(
          json as Map<String, dynamic>,
          (json) => Book.fromJson(json as Map<String, dynamic>),
        ),
      );
    } on DioException catch (e) {
      log.e('Get books failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Get books failed: $e');

      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }
}
