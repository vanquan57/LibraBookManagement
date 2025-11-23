import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/helper/error_parser.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/core/response/error_default_response.dart';
import 'package:mobile/share/data/models/wishlist/wishlist.dart';

@lazySingleton
class WishlistRemoteDataSource {
  final Dio _dio;

  WishlistRemoteDataSource(this._dio);

  /// Get the user's wishlist
  ///
  /// @return Future<ApiResponse<List<Wishlist>>>
  Future<ApiResponse<List<Wishlist>>?> getWishlist() async {
    try {
      final response = await _dio.get('/wish-list');

      return ApiResponse<List<Wishlist>>.fromJson(
        response.data,
        (data) =>
            (data as List).map((item) => Wishlist.fromJson(item)).toList(),
      );
    } on DioException catch (e) {
      log.e('Get wishlist failed: ${getErrorMessage(e)}');

      return null;
    } catch (e) {
      log.e('Get wishlist failed w: $e');
      return null;
    }
  }

  /// Add a book to wishlist
  ///
  /// @param int bookId
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  Future<ApiResponse<Map<String, dynamic>>> addBookToWishlist(int bookId) async {
    try {
      final response = await _dio.post('/wish-list', data: {'book_id': bookId});

      return ApiResponse<Map<String, dynamic>>.fromJson(
        response.data,
        (data) => data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      log.e('Add book to wishlist failed: ${getErrorMessage(e)}');

      return ApiResponse<Map<String, dynamic>>.fromJson(
        e.response?.data ??
            buildErrorResponse("Thêm sách vào danh sách yêu thích thất bại"),
        (data) => data as Map<String, dynamic>,
      );
    } catch (e) {
      log.e('Add book to wishlist failed w: $e');

      return ApiResponse<Map<String, dynamic>>.fromJson(
        buildErrorResponse("Thêm sách vào danh sách yêu thích thất bại"),
        (data) => data as Map<String, dynamic>,
      );
    }
  }

  /// Remove a book from wishlist
  ///
  /// @param int bookId
  ///
  /// @return ApiResponse<Map<String, dynamic>>
  Future<ApiResponse<Map<String, dynamic>>> deleteBookFromWishlist(int bookId) async {
    try {
      final response = await _dio.delete('/wish-list/$bookId');

      return ApiResponse<Map<String, dynamic>>.fromJson(
        response.data,
        (data) => data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      log.e('Remove book from wishlist failed: ${getErrorMessage(e)}');

      return ApiResponse<Map<String, dynamic>>.fromJson(
        e.response?.data ??
            buildErrorResponse("Xóa sách khỏi danh sách yêu thích thất bại"),
        (data) => data as Map<String, dynamic>,
      );
    } catch (e) {
      log.e('Remove book from wishlist failed w: $e');

      return ApiResponse<Map<String, dynamic>>.fromJson(
        buildErrorResponse("Xóa sách khỏi danh sách yêu thích thất bại"),
        (data) => data as Map<String, dynamic>,
      );
    }
  }
}
