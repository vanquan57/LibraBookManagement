import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/cart/domain/usecase/cart_param.dart';
import 'package:mobile/share/data/models/cart/cart.dart';

abstract class CartRepository { 
  /// Get cart books
  ///
  /// @param BookParams params
  ///
  /// @return Future<ApiResponse<List<Cart>>> 
  Future<ApiResponse<List<Cart>>?> getCart();

  /// Add a book to cart
  ///
  /// @param List<CartParam> carts
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  Future<ApiResponse<Map<String, dynamic>>> addBookToCart(List<CartParam> carts);
  
  /// Update a book in cart
  ///
  /// @param List<CartParam> carts
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  Future<ApiResponse<Map<String, dynamic>>> updateCart(List<CartParam> carts);


  /// Remove a book from cart
  ///
  /// @param int bookId
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  Future<ApiResponse<Map<String, dynamic>>> deleteBookFromCart(int bookId);
}
