import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/book_details/domain/repositories/book/book_repository.dart';
import 'package:mobile/share/data/models/book/book.dart';

@lazySingleton
class GetBookDetailUseCase {
  final BookRepository repository;

  // SYNC constructor
  GetBookDetailUseCase(this.repository);

  /// Get book details
  ///
  /// @param int bookId
  ///
  /// @return Future<ApiResponse<Book>>
  Future<ApiResponse<Book>> call(int bookId) async {
    return await repository.getBookDetails(bookId);
  }
}
