import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/config/constant.dart';
import 'package:mobile/core/helper/error_parser.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/home/domain/usecase/book/get_books.dart';
import 'package:mobile/share/data/models/book/book.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

@lazySingleton
class BookRemoteDataSource {
  final Dio _dio;

  BookRemoteDataSource(this._dio);

  /// Get top books most borrowed
  ///
  /// @param BookParams params
  ///
  /// @return Future<ApiResponse<Paginated<Book>>>
  Future<ApiResponse<Paginated<Book>>> getBooks(BookParams params) async {
    try {
      final queryParameters = <String, dynamic>{};

      queryParameters['page'] = params.page;
      if (params.limit != null) queryParameters['limit'] = params.limit;
      if (params.mostBorrowed != null) queryParameters['most_borrowed'] = params.mostBorrowed;
      if (params.mostViewed != null) queryParameters['most_viewed'] = params.mostViewed;
      if (params.latest != null) queryParameters['latest'] = params.latest;
      if (params.order != null) queryParameters['order'] = params.order;

      final response = await _dio.get(
        '/book',
        queryParameters: queryParameters,
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => Paginated<Book>.fromJson(
          json as Map<String, dynamic>,
          (json) => Book.fromJson(json as Map<String, dynamic>),
        ),
      );
    } on DioException catch (e) {
      log.e('Get top borrowed books failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Get top borrowed books failed: $e');

      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }
}
