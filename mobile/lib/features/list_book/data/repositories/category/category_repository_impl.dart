import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/list_book/data/datasources/category/category_remote_datasource.dart';
import 'package:mobile/features/list_book/domain/repositories/category/category_repository.dart';
import 'package:mobile/share/data/models/category/category.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  // SYNC constructor
  CategoryRepositoryImpl(this.remoteDataSource);

  /// Get list of categories
  ///
  /// @param {number} limit - The limit number
  ///
  /// @return Future<ApiResponse<Paginated<Category>>> 
  @override
  Future<ApiResponse<Paginated<Category>>> getCategories(int limit) {
    return remoteDataSource.getCategories(limit: limit);
  }
}
