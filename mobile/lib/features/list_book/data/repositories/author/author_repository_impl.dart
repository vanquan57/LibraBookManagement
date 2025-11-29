import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/list_book/data/datasources/author/author_remote_datasource.dart';
import 'package:mobile/features/list_book/domain/repositories/author/author_repository.dart'; 
import 'package:mobile/share/data/models/author/author.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

@LazySingleton(as: AuthorRepository)
class AuthorRepositoryImpl implements AuthorRepository {
  final AuthorRemoteDataSource remoteDataSource;

  // SYNC constructor
  AuthorRepositoryImpl(this.remoteDataSource);

  /// Get list of authors
  ///
  /// @param {number} limit - The limit number
  ///
  /// @return Future<ApiResponse<Paginated<Author>>> 
  @override
  Future<ApiResponse<Paginated<Author>>> getAuthors(int limit) {
    return remoteDataSource.getAuthors(limit: limit);
  }
}
