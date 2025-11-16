import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/share/data/models/category/category.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

abstract class CategoryRepository {
  /// Get top books most borrowed
  ///
  /// @param {number} page - The page number
  ///
  /// @return Future<ApiResponse<Paginated<Category>>> 
  Future<ApiResponse<Paginated<Category>>> getCategories(int page);
}
