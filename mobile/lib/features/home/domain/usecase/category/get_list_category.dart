import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/home/domain/repositories/category/category_repository.dart';
import 'package:mobile/share/data/models/book/book.dart';
import 'package:mobile/share/data/models/category/category.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';
import 'package:mobile/features/home/domain/repositories/book/book_repository.dart';

@lazySingleton
class GetListCategoriesUseCase {
  final CategoryRepository repository;

  // SYNC constructor
  GetListCategoriesUseCase(this.repository);

  /// Get top books most borrowed
  ///
  /// @param {number} page - The page number
  ///
  /// @return Future<ApiResponse<Paginated<Category>>> 
  Future<ApiResponse<Paginated<Category>>> call(int page) async {
    return await repository.getCategories(page);
  }
}
