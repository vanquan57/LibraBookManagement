import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/book_details/domain/usecase/feedback/create_feedback.dart';
import 'package:mobile/features/book_details/domain/usecase/feedback/get_feedbacks.dart';
import 'package:mobile/share/data/models/feedback/feedback.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

abstract class FeedbackRepository {
  /// Get feedbacks by book ID.
  ///
  /// @param FeedbackParams params
  ///
  /// @return Future<ApiResponse<Paginated<Feedback>>>
  Future<ApiResponse<Paginated<Feedback>>> getFeedbacks(FeedbackParams params);

  /// Create feedback by book ID.
  ///
  /// @param CreateFeedbackParams params
  ///
  /// @return Future<ApiResponse<String>>
  Future<ApiResponse<String>> createFeedback(CreateFeedbackParams params);
}
