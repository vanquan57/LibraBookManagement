import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/cart/domain/repositories/cart_repository.dart';
import 'package:mobile/features/cart/domain/usecase/cart_param.dart';

@lazySingleton
class AddCartUseCase {
  final CartRepository repository;

  // SYNC constructor
  AddCartUseCase(this.repository);

  /// Add a book to cart
  ///
  /// @param List<CartParam> carts
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  Future<ApiResponse<Map<String, dynamic>>> call(List<CartParam> carts) async { 
    return await repository.addBookToCart(carts);  
  }
}

