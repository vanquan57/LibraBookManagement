import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/list_book/domain/repositories/category/category_repository.dart';
import 'package:mobile/share/data/models/category/category.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

@lazySingleton
class GetListCategoriesUseCase {
  final CategoryRepository repository;

  // SYNC constructor
  GetListCategoriesUseCase(this.repository);

  /// Get list of categories
  ///
  /// @param {number} limit - The limit number
  ///
  /// @return Future<ApiResponse<Paginated<Category>>> 
  Future<ApiResponse<Paginated<Category>>> call(int limit) async {
    return await repository.getCategories(limit);
  }
}
