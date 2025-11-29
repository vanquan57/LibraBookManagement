import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/list_book/domain/repositories/author/author_repository.dart';
import 'package:mobile/share/data/models/author/author.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

@lazySingleton
class GetListAuthorsUseCase {
  final AuthorRepository repository;

  // SYNC constructor
  GetListAuthorsUseCase(this.repository);

  /// Get list of authors
  ///
  /// @param {number} limit - The limit number
  ///
  /// @return Future<ApiResponse<Paginated<Author>>> 
  Future<ApiResponse<Paginated<Author>>> call(int limit) async {
    return await repository.getAuthors(limit);
  }
}
