import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/features/wishlist/domain/usecase/add_wishlist.dart';
import 'package:mobile/features/wishlist/domain/usecase/delete_wishlist.dart';
import 'package:mobile/features/wishlist/domain/usecase/get_wishlist.dart';
import 'package:mobile/share/data/models/wishlist/wishlist.dart';

@injectable
class WishlistProvider extends ChangeNotifier {
  final GetWishListUseCase getWishListUseCase;
  final AddWishListUseCase addWishListUseCase;
  final DeleteWishListUseCase deleteWishListUseCase;

  // SYNC constructor
  WishlistProvider(
    this.getWishListUseCase,
    this.addWishListUseCase,
    this.deleteWishListUseCase,
  );

  // List wishlist books
  final List<Wishlist> _wishList = [];
  List<Wishlist> get wishList => List.unmodifiable(_wishList);

  // List wishlist book IDs
  final List<int> _wishListIds = [];
  List<int> get wishListIds => List.unmodifiable(_wishListIds);

  // State response
  bool isSuccess = true;
  String message = '';
  bool _isShowDialog = false;
  
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

  /// Get wishlist books
  ///
  /// @param BookParams params
  ///
  /// @return Future<ApiResponse<List<Wishlist>>>
  Future<void> getWishlist() async {
    final response = await getWishListUseCase();

    if (response != null && response.data != null) {
      _wishList.clear();
      _wishList.addAll(response.data!);

      notifyListeners();
    }
  }

  /// Initialize wishlist
  ///
  /// @param List<Wishlist> wishlists
  ///
  /// @return void
  void initializeWishList() async {
    await getWishlist();

    _wishListIds.clear();

    if (_wishList.isNotEmpty) {
      _wishListIds.addAll(_wishList.map((e) => e.book.id));
    }

    notifyListeners();
  }

  /// Add a book to wishlist
  ///
  /// @param int bookId
  ///
  /// @return void
  void addToWishList(int bookId) async {
    if (!_wishListIds.contains(bookId)) {
      final response = await addWishListUseCase(bookId);

      if (response.success) {
        isSuccess = true;
        message = response.data?['message'] ?? '';

        _wishListIds.add(bookId);
      } else {
        isSuccess = false;
        message =
            response.data?['error_message'] ??
            response.errors?['error_message'] ??
            '';
      }

      _isShowDialog = true;
      notifyListeners();
    }
  }

  /// Remove a book from wishlist
  ///
  /// @param int bookId
  ///
  /// @return void
  void removeFromWishList(int bookId) async {
    final response = await deleteWishListUseCase(bookId);

    if (response.success) {
      isSuccess = true;
      message = response.data?['message'] ?? '';

      _wishListIds.remove(bookId);
      _wishList.removeWhere((item) => item.book.id == bookId);
    } else {
      isSuccess = false;
      message =
          response.data?['error_message'] ??
          response.errors?['error_message'] ??
          '';
    }

    _isShowDialog = true;
    notifyListeners();
  }

  /// Check if a book is in the wishlist
  ///
  /// @param int bookId
  ///
  /// @return bool
  bool isInWishList(int bookId) => _wishListIds.contains(bookId);
}
