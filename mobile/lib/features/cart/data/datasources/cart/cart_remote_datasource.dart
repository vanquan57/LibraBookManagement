import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/helper/error_parser.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/core/response/error_default_response.dart';
import 'package:mobile/features/cart/domain/usecase/cart_param.dart';
import 'package:mobile/share/data/models/cart/cart.dart';

@lazySingleton
class CartRemoteDataSource {
  final Dio _dio;

  CartRemoteDataSource(this._dio);

  /// Get the user's cart books
  ///
  /// @return Future<ApiResponse<List<Cart>>>
  Future<ApiResponse<List<Cart>>?> getCart() async {
    try {
      final response = await _dio.get('/cart');

      return ApiResponse<List<Cart>>.fromJson(
        response.data,
        (data) =>
            (data as List).map((item) => Cart.fromJson(item)).toList(),
      );
    } on DioException catch (e) {
      log.e('Get card failed: ${getErrorMessage(e)}');

      return null;
    } catch (e) {
      log.e('Get cart failed w: $e');
      
      return null;
    }
  }

  /// Add a book to cart  
  ///
  /// @param List<CartParam> carts
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  Future<ApiResponse<Map<String, dynamic>>> addBookToCart(List<CartParam> carts) async {   
    try {
      final response = await _dio.post('/cart', data: {'cart': carts.map((e) => e.toJson()).toList()});

      return ApiResponse<Map<String, dynamic>>.fromJson(
        response.data,
        (data) => data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      log.e('Add book to cart failed: ${getErrorMessage(e)}');

      return ApiResponse<Map<String, dynamic>>.fromJson(
        e.response?.data ??
            buildErrorResponse("Thêm sách vào giỏ mượn thất bại"),
        (data) => data as Map<String, dynamic>,
      );
    } catch (e) {
      log.e('Add book to cart failed w: $e');

      return ApiResponse<Map<String, dynamic>>.fromJson(
        buildErrorResponse("Thêm sách vào giỏ mượn thất bại"),
        (data) => data as Map<String, dynamic>,
      );
    }
  }
  
  /// Update a book in cart
  ///
  /// @param List<CartParam> carts
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  Future<ApiResponse<Map<String, dynamic>>> updateCart(List<CartParam> carts) async {   
    try {
      final response = await _dio.put('/cart', data: {'cart': carts.map((e) => e.toJson()).toList()});

      return ApiResponse<Map<String, dynamic>>.fromJson(
        response.data,
        (data) => data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      log.e('Update book in cart failed: ${getErrorMessage(e)}');

      return ApiResponse<Map<String, dynamic>>.fromJson(
        e.response?.data ??
            buildErrorResponse("Cập nhật sách trong giỏ mượn thất bại"),
        (data) => data as Map<String, dynamic>,
      );
    } catch (e) {
      log.e('Update book in cart failed w: $e');

      return ApiResponse<Map<String, dynamic>>.fromJson(
        buildErrorResponse("Cập nhật sách trong giỏ mượn thất bại"),
        (data) => data as Map<String, dynamic>,
      );
    }
  }

  /// Remove a book from cart 
  ///
  /// @param int bookId
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  Future<ApiResponse<Map<String, dynamic>>> deleteBookFromCart(int bookId) async {
    try {
      final response = await _dio.delete('/cart/$bookId');

      return ApiResponse<Map<String, dynamic>>.fromJson(
        response.data,
        (data) => data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      log.e('Remove book from cart failed: ${getErrorMessage(e)}');

      return ApiResponse<Map<String, dynamic>>.fromJson(
        e.response?.data ??
            buildErrorResponse("Xóa sách khỏi giỏ mượn thất bại"),   
        (data) => data as Map<String, dynamic>,
      );
    } catch (e) {
      log.e('Remove book from cart failed w: $e');

      return ApiResponse<Map<String, dynamic>>.fromJson(
        buildErrorResponse("Xóa sách khỏi giỏ mượn thất bại"),
        (data) => data as Map<String, dynamic>,
      );
    }
  }
}
