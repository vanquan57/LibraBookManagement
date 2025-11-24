import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/cart/data/datasources/cart/cart_remote_datasource.dart';
import 'package:mobile/features/cart/domain/repositories/cart_repository.dart';
import 'package:mobile/features/cart/domain/usecase/cart_param.dart';
import 'package:mobile/share/data/models/cart/cart.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  // SYNC constructor
  CartRepositoryImpl(this.remoteDataSource);

  /// Get cart books    
  ///
  /// @param BookParams params
  ///
  /// @return Future<ApiResponse<List<Cart>>> 
  @override
  Future<ApiResponse<List<Cart>>?> getCart() {
    return remoteDataSource.getCart();
  }

  /// Add a book to cart
  ///
  /// @param List<CartParam> carts
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  @override
  Future<ApiResponse<Map<String, dynamic>>> addBookToCart(List<CartParam> carts) async {
    return await remoteDataSource.addBookToCart(carts);
  }
  
  /// Update a book in cart
  ///
  /// @param List<CartParam> carts
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  @override
  Future<ApiResponse<Map<String, dynamic>>> updateCart(List<CartParam> carts) async {
    return await remoteDataSource.updateCart(carts);
  }

  /// Remove a book from cart
  ///
  /// @param int bookId
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  @override
  Future<ApiResponse<Map<String, dynamic>>> deleteBookFromCart(int bookId) async {
    return await remoteDataSource.deleteBookFromCart(bookId);
  }
}
