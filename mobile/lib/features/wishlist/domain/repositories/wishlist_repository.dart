import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/share/data/models/wishlist/wishlist.dart';

abstract class WishlistRepository {
  /// Get wishlist books
  ///
  /// @param BookParams params
  ///
  /// @return Future<ApiResponse<List<Wishlist>>>
  Future<ApiResponse<List<Wishlist>>?> getWishlist();

  /// Add a book to wishlist
  ///
  /// @param int bookId
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  Future<ApiResponse<Map<String, dynamic>>> addBookToWishlist(int bookId);


  /// Remove a book from wishlist
  ///
  /// @param int bookId
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  Future<ApiResponse<Map<String, dynamic>>> deleteBookFromWishlist(int bookId);
}
