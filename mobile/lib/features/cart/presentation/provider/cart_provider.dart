import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/features/cart/domain/usecase/add_card.dart';
import 'package:mobile/features/cart/domain/usecase/cart_param.dart';
import 'package:mobile/features/cart/domain/usecase/delete_card.dart';
import 'package:mobile/features/cart/domain/usecase/get_card.dart';
import 'package:mobile/features/cart/domain/usecase/update_card.dart';
import 'package:mobile/share/data/models/cart/cart.dart';

@injectable
class CartProvider extends ChangeNotifier {
  final GetCartUseCase getCartUseCase;
  final AddCartUseCase addCartUseCase;
  final UpdateCartUseCase updateCartUseCase;
  final DeleteCartUseCase deleteCartUseCase;

  // SYNC constructor
  CartProvider(
    this.getCartUseCase,
    this.addCartUseCase,
    this.deleteCartUseCase,
    this.updateCartUseCase,
  );

  // List cart books
  final List<Cart> _carts = [];
  List<Cart> get carts => List.unmodifiable(_carts);

  // State response
  bool isSuccess = true;
  bool isContinue = false;
  String _message = '';
  String get message => _message;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _isShowDialog = false;

  //  Cart checkout data
  List<Map<String, dynamic>> cartCheckoutData = [];

  /// Get and reset dialog flag (consume once)
  bool get isShowDialog {
    final shouldShow = _isShowDialog;
    if (_isShowDialog) {
      _isShowDialog = false;
    }

    return shouldShow;
  }

  set isShowDialog(bool value) {
    _isShowDialog = value;
  }

  /// Get cart books
  ///
  /// @return void
  Future<void> getCart() async {
    final response = await getCartUseCase();

    if (response != null && response.data != null) {
      _carts.clear();
      _carts.addAll(response.data!);

      notifyListeners();
    }
  }

  /// Add a book to cart
  ///
  /// @param List<Map<String, dynamic>> carts
  ///
  /// @return void
  void addToCart(List<Map<String, dynamic>> carts) async {
    if (carts.isEmpty) {
      isSuccess = false;
      _message = 'Vui lòng chọn sách để thêm vào giỏ hàng.';
      _isShowDialog = true;

      notifyListeners();

      return;
    }

    final List<CartParam> cartParams = [];

    for (var cartItem in carts) {
      final bookId = cartItem['book_id'] as int;
      final quantity = cartItem['quantity'] as int;

      cartParams.add(CartParam(bookId: bookId, quantity: quantity));
    }

    final response = await addCartUseCase(cartParams);

    if (response.success) {
      isSuccess = true;
      final messageData = response.data?['message'];

      if (messageData is Map<String, dynamic>) {
        final successMsg = (messageData['success'] ?? '').toString();
        final errorMsg = (messageData['error'] ?? '').toString();

        if (successMsg.isNotEmpty) {
          _message = successMsg; 
        }

        if (errorMsg.isNotEmpty) {
          isSuccess = false;
          _errorMessage = errorMsg;   
        }

        if (successMsg.isNotEmpty && errorMsg.isNotEmpty) {
          isContinue = true;
        }
      }

      await getCart();
    } else {
      isSuccess = false;
      _message =
          response.data?['error_message'] ??
          response.errors?['error_message'] ??
          '';
    }

    _isShowDialog = true;
    notifyListeners();
  }

  /// Update a book in cart
  ///
  /// @param List<Map<String, dynamic>> carts
  ///
  /// @return void
  void updateCart(List<Map<String, dynamic>> carts) async {
    if (carts.isEmpty) {
      isSuccess = false;
      _message = 'Giỏ hàng trống, không thể cập nhật';
      _isShowDialog = true;

      notifyListeners();

      return;
    }

    final List<CartParam> cartParams = [];

    for (var cartItem in carts) {
      final bookId = cartItem['book_id'] as int;
      final quantity = cartItem['quantity'] as int;

      cartParams.add(CartParam(bookId: bookId, quantity: quantity));
    }

    final response = await updateCartUseCase(cartParams);

    if (response.success) {
      isSuccess = true;
      final messageData = response.data?['message'];

      if (messageData is Map<String, dynamic>) {
        final successMsg = (messageData['success'] ?? '').toString();
        final errorMsg = (messageData['error'] ?? '').toString();

        if (successMsg.isNotEmpty) {
          _message = successMsg;
        }

        if (errorMsg.isNotEmpty) {
          isSuccess = false;
          _errorMessage = errorMsg;
        }
      }

      await getCart();
    } else {
      isSuccess = false;
      _message =
          response.data?['error_message'] ??
          response.errors?['error_message'] ??
          '';
    }

    _isShowDialog = true;
    notifyListeners();
  }

  /// Remove a book from cart
  ///
  /// @param int bookId
  ///
  /// @return void
  void removeFromCart(int bookId) async {
    final response = await deleteCartUseCase(bookId);

    if (response.success) {
      isSuccess = true;
      _message = response.data?['message'] ?? '';

      _carts.removeWhere((item) => item.book.id == bookId);
    } else {
      isSuccess = false;
      _message =
          response.data?['error_message'] ??
          response.errors?['error_message'] ??
          '';
    }

    _isShowDialog = true;
    notifyListeners();
  }
}
