import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/share/data/models/book/book.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

abstract class BookRepository {
  /// Get book details by book ID.
  ///
  /// @param int bookId
  ///
  /// @return Future<ApiResponse<Book>>
  Future<ApiResponse<Book>> getBookDetails(int bookId);

  /// Get book same category by category ID.
  ///
  /// @param int categoryId
  /// @param int limit
  ///
  /// @return Future<ApiResponse<Paginated<Book>>>
  Future<ApiResponse<Paginated<Book>>> getBookSameCategory(
    int categoryId,
    int limit,
  );
}
