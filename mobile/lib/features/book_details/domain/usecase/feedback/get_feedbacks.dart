import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/book_details/domain/repositories/feedback/feedback_repository.dart';
import 'package:mobile/share/data/models/feedback/feedback.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

@lazySingleton
class GetFeedbacksUseCase {
  final FeedbackRepository repository;

  // SYNC constructor
  GetFeedbacksUseCase(this.repository);

  /// Get feedbacks
  ///
  /// @param FeedbackParams params
  ///
  /// @return Future<ApiResponse<Paginated<Feedback>>>
  Future<ApiResponse<Paginated<Feedback>>> call(FeedbackParams params) async {
    return await repository.getFeedbacks(params);
  }
}

// Class contain feedback parameters.
class FeedbackParams extends Equatable {
  final int bookId;
  final int page;
  final int? limit;
  final String? order;
  final String? column;

  const FeedbackParams({
    required this.bookId,
    required this.page,
    this.limit,
    this.order,
    this.column,
  });

  @override
  List<Object?> get props => [bookId, page, limit, order, column];
}
