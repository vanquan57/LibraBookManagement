import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/book_details/data/datasources/feedback/feedback_remote_datasource.dart';
import 'package:mobile/features/book_details/domain/repositories/feedback/feedback_repository.dart';
import 'package:mobile/features/book_details/domain/usecase/feedback/create_feedback.dart';
import 'package:mobile/features/book_details/domain/usecase/feedback/get_feedbacks.dart';
import 'package:mobile/share/data/models/feedback/feedback.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

@LazySingleton(as: FeedbackRepository)
class FeedbackRepositoryImpl implements FeedbackRepository {
  final FeedbackRemoteDataSource remoteDataSource;

  // SYNC constructor
  FeedbackRepositoryImpl(this.remoteDataSource);

  /// Get feedbacks by book ID.
  ///
  /// @param FeedbackParams params
  ///
  /// @return Future<ApiResponse<Paginated<Feedback>>>
  @override
  Future<ApiResponse<Paginated<Feedback>>> getFeedbacks(FeedbackParams params) {
    return remoteDataSource.getFeedbacks(params);
  }

  /// Create feedback by book ID.
  ///
  /// @param CreateFeedbackParams params
  ///
  /// @return Future<ApiResponse<String>>
  @override
  Future<ApiResponse<String>> createFeedback(CreateFeedbackParams params) {
    return remoteDataSource.createFeedback(params);
  }
}
