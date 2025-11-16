import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/share/data/models/book/book.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';
import 'package:mobile/features/home/domain/usecase/book/get_books.dart';

abstract class BookRepository {
  /// Get books 
  ///
  /// @param BookParams params
  ///
  /// @return Future<ApiResponse<Paginated<Book>>> 
  Future<ApiResponse<Paginated<Book>>> getBooks(BookParams params);
}
