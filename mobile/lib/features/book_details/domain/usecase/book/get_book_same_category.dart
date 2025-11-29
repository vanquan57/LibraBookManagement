import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/book_details/domain/repositories/book/book_repository.dart';
import 'package:mobile/share/data/models/book/book.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

@lazySingleton
class GetBookSameCategoryUseCase {
  final BookRepository repository;

  // SYNC constructor
  GetBookSameCategoryUseCase(this.repository);

  /// Get book same category
  ///
  /// @param int categoryId
  /// @param int limit
  ///
  /// @return Future<ApiResponse<Paginated<Book>>>
  Future<ApiResponse<Paginated<Book>>> call(int categoryId, int limit) async {
    return await repository.getBookSameCategory(categoryId, limit);
  }
}
