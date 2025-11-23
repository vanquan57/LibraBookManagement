import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:mobile/share/data/models/wishlist/wishlist.dart';

@lazySingleton
class GetWishListUseCase {
  final WishlistRepository repository;

  // SYNC constructor
  GetWishListUseCase(this.repository);

  /// Get books in wishlist
  ///
  /// @param BookParams params
  ///
  /// @return Future<ApiResponse<List<Wishlist>>>
  Future<ApiResponse<List<Wishlist>>?> call() async {
    return await repository.getWishlist();
  }
}
