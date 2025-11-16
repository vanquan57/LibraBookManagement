import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/home/data/datasources/category/category_remote_datasource.dart';
import 'package:mobile/features/home/domain/repositories/category/category_repository.dart';
import 'package:mobile/share/data/models/book/book.dart';
import 'package:mobile/share/data/models/category/category.dart';
import 'package:mobile/share/data/models/paginated/paginated.dart';
import '../../../domain/repositories/book/book_repository.dart';
import '../../datasources/book/book_remote_datasource.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  // SYNC constructor
  CategoryRepositoryImpl(this.remoteDataSource);

  /// Get top books most borrowed
  ///
  /// @param {number} page - The page number
  ///
  /// @return Future<ApiResponse<Paginated<Category>>> 
  @override
  Future<ApiResponse<Paginated<Category>>> getCategories(int page) {
    return remoteDataSource.getCategories(page: page);
  }
}
