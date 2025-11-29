import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/book_details/domain/repositories/feedback/feedback_repository.dart';

@lazySingleton
class CreateFeedbackUseCase {
  final FeedbackRepository repository;

  // SYNC constructor
  CreateFeedbackUseCase(this.repository);

  /// Get feedbacks
  ///
  /// @param CreateFeedbackParams params
  ///
  /// @return Future<ApiResponse<String>>
  Future<ApiResponse<String>> call(CreateFeedbackParams params) async {
    return await repository.createFeedback(params);
  }
}

// Class contain feedback parameters.
class CreateFeedbackParams extends Equatable {
  final int bookId;
  final String content;
  final int star;

  const CreateFeedbackParams({
    required this.bookId,
    required this.content,
    required this.star,
  });

  @override
  List<Object?> get props => [bookId, content, star];
}
