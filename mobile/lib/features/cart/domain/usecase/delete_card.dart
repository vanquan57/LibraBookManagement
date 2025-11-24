import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/cart/domain/repositories/cart_repository.dart';

@lazySingleton
class DeleteCartUseCase {
  final CartRepository repository;

  // SYNC constructor
  DeleteCartUseCase(this.repository);

  /// Delete book in cart
  ///
  /// @param int bookId
  ///
  /// @return Future<ApiResponse<Map<String, dynamic>>>
  Future<ApiResponse<Map<String, dynamic>>> call(int bookId) async {
    return await repository.deleteBookFromCart(bookId);
  }
}
