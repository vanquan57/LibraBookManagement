import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/book_details/data/datasources/book/book_remote_datasource.dart';
import 'package:mobile/features/book_details/domain/repositories/book/book_repository.dart';
import 'package:mobile/share/data/models/book/book.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

@LazySingleton(as: BookRepository)
class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;

  // SYNC constructor
  BookRepositoryImpl(this.remoteDataSource);

  /// Get book details by book ID.
  ///
  /// @param int bookId
  ///
  /// @return Future<ApiResponse<Book>>
  @override
  Future<ApiResponse<Book>> getBookDetails(int bookId) {
    return remoteDataSource.getBookDetails(bookId);
  }

  /// Get book same category by category ID.
  ///
  /// @param int categoryId
  /// @param int limit
  ///
  /// @return Future<ApiResponse<Paginated<Book>>>
  @override
  Future<ApiResponse<Paginated<Book>>> getBookSameCategory(
    int categoryId,
    int limit,
  ) {
    return remoteDataSource.getBookSameCategory(categoryId, limit);
  }
}
