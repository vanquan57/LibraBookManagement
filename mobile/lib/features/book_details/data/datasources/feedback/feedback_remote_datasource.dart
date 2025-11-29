import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/helper/error_parser.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/book_details/domain/usecase/feedback/create_feedback.dart';
import 'package:mobile/features/book_details/domain/usecase/feedback/get_feedbacks.dart';
import 'package:mobile/share/data/models/feedback/feedback.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

@lazySingleton
class FeedbackRemoteDataSource {
  final Dio _dio;

  FeedbackRemoteDataSource(this._dio);

  /// Get feedbacks by book ID.
  ///
  /// @param FeedbackParams params
  ///
  /// @return Future<ApiResponse<Paginated<Feedback>>>
  Future<ApiResponse<Paginated<Feedback>>> getFeedbacks(
    FeedbackParams params,
  ) async {
    try {
      final queryParameters = <String, dynamic>{
        'book_id': params.bookId,
        'page': params.page,
      };

      if (params.limit != null) {
        queryParameters['limit'] = params.limit;
      }
      if (params.column != null) {
        queryParameters['column'] = params.column;
      }
      if (params.order != null) {
        queryParameters['order'] = params.order;
      }

      final response = await _dio.get(
        '/feedbacks',
        queryParameters: queryParameters,
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => Paginated<Feedback>.fromJson(
          json as Map<String, dynamic>,
          (json) => Feedback.fromJson(json as Map<String, dynamic>),
        ),
      );
    } on DioException catch (e) {
      log.e('Get feedbacks failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Get feedbacks failed: $e');

      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }

  /// Create feedback by book ID.
  ///
  /// @param CreateFeedbackParams params
  ///
  /// @return Future<ApiResponse<String>>
  Future<ApiResponse<String>> createFeedback(
    CreateFeedbackParams params,
  ) async {
    try {
      final response = await _dio.post(
        '/feedback',
        data: {
          'book_id': params.bookId,
          'content': params.content,
          'star': params.star,
        },
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => json['message'] as String,
      );
    } on DioException catch (e) {
      log.e('Create feedback failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Create feedback failed: $e');

      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }
}
