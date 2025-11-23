import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/wishlist/domain/repositories/wishlist_repository.dart';

@lazySingleton
class DeleteWishListUseCase {
  final WishlistRepository repository;

  // SYNC constructor
  DeleteWishListUseCase(this.repository);

  /// Delete book in wishlist
  ///
  /// @param int bookId
  ///
  /// @return Future<ApiResponse<Map<String, dynamic>>>
  Future<ApiResponse<Map<String, dynamic>>> call(int bookId) async {
    return await repository.deleteBookFromWishlist(bookId);
  }
}
