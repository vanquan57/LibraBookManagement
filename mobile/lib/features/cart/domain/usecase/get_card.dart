import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/cart/domain/repositories/cart_repository.dart';
import 'package:mobile/share/data/models/cart/cart.dart';

@lazySingleton
class GetCartUseCase {
  final CartRepository repository;

  // SYNC constructor
  GetCartUseCase(this.repository);

  /// Get books in cart 
  ///
  /// @param BookParams params
  ///
  /// @return Future<ApiResponse<List<Cart>>> 
  Future<ApiResponse<List<Cart>>?> call() async {
    return await repository.getCart();
  }
}
