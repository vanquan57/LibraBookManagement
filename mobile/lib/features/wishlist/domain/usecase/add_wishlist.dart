import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/wishlist/domain/repositories/wishlist_repository.dart';

@lazySingleton
class AddWishListUseCase {
  final WishlistRepository repository;

  // SYNC constructor
  AddWishListUseCase(this.repository);

  /// Add a book to wishlist
  ///
  /// @param int bookId
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  Future<ApiResponse<Map<String, dynamic>>> call(int bookId) async { 
    return await repository.addBookToWishlist(bookId);
  }
}
