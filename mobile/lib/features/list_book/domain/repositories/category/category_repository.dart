import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/share/data/models/category/category.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

abstract class CategoryRepository {
  /// Get list of categories
  ///
  /// @param {number} limit - The limit number
  ///
  /// @return Future<ApiResponse<Paginated<Category>>> 
  Future<ApiResponse<Paginated<Category>>> getCategories(int limit);
}
