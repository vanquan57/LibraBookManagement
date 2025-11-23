import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/wishlist/data/datasources/wishlist/wishlist_remote_datasource.dart';
import 'package:mobile/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:mobile/share/data/models/wishlist/wishlist.dart';

@LazySingleton(as: WishlistRepository)
class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource remoteDataSource;

  // SYNC constructor
  WishlistRepositoryImpl(this.remoteDataSource);

  /// Get wishlist books
  ///
  /// @param BookParams params
  ///
  /// @return Future<ApiResponse<List<Wishlist>>>
  @override
  Future<ApiResponse<List<Wishlist>>?> getWishlist() {
    return remoteDataSource.getWishlist();
  }

  /// Add a book to wishlist
  ///
  /// @param int bookId
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  @override
  Future<ApiResponse<Map<String, dynamic>>> addBookToWishlist(int bookId) async {
    return await remoteDataSource.addBookToWishlist(bookId);
  }

  /// Remove a book from wishlist
  ///
  /// @param int bookId
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  @override
  Future<ApiResponse<Map<String, dynamic>>> deleteBookFromWishlist(int bookId) async {
    return await remoteDataSource.deleteBookFromWishlist(bookId);
  }
}
