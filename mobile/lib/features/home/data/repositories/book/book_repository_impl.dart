import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/share/data/models/book/book.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';
import '../../../domain/repositories/book/book_repository.dart';
import '../../../domain/usecase/book/get_books.dart';
import '../../datasources/book/book_remote_datasource.dart';

@LazySingleton(as: BookRepository)
class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;

  // SYNC constructor
  BookRepositoryImpl(this.remoteDataSource);

  /// Get books 
  ///
  /// @param BookParams params
  ///
  /// @return Future<ApiResponse<Paginated<Book>>>
  @override
  Future<ApiResponse<Paginated<Book>>> getBooks(BookParams params) {
    return remoteDataSource.getBooks(params);
  }
}
