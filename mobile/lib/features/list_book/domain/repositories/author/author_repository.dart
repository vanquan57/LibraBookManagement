import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/share/data/models/author/author.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

abstract class AuthorRepository { 
  /// Get list of authors
  ///
  /// @param {number} limit - The limit number
  ///
  /// @return Future<ApiResponse<Paginated<Author>>> 
  Future<ApiResponse<Paginated<Author>>> getAuthors(int limit);
}
