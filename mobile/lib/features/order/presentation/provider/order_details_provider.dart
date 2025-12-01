import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/features/order/domain/usecase/order/get_order_details.dart';
import 'package:mobile/features/order/domain/usecase/order/update_book_order.dart';
import 'package:mobile/share/data/models/order/order.dart' as OrderModel;

@injectable
class OrderDetailsProvider extends ChangeNotifier {
  final GetOrderDetailsUseCase getOrderDetailsUseCase;
  final UpdateBookOrderUseCase updateBookOrderUseCase;

  // SYNC constructor
  OrderDetailsProvider(
    this.getOrderDetailsUseCase,
    this.updateBookOrderUseCase,
  );

  // Order details state
  OrderModel.Order? _orderDetails;
  OrderModel.Order? get orderDetails => _orderDetails;

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  bool _isShowDialog = false;
  bool get isShowDialog => _isShowDialog;
  set isShowDialog(bool value) {
    _isShowDialog = value;
    notifyListeners();
  }

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _message;
  String? get message => _message;

  /// Get orders details
  /// 
  /// @param int page
  ///
  /// @return Future<void>
  Future<void> getOrdersDetails(int orderId) async {
    _isLoading = true;
    notifyListeners();

    final response = await getOrderDetailsUseCase(orderId);
    
    if (response.success && response.data != null) {
      _orderDetails = response.data;
      _errorMessage = null;
    } else {
      if (response.errors is Map) {
        _errorMessage = response.errors['error_message']?.toString() ?? 'Đã có lỗi xảy ra';
      } else {
        _errorMessage = response.errors?.toString() ?? 'Đã có lỗi xảy ra';
      }
      
      _orderDetails = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Reset dialog state
  /// 
  /// @return void
  void resetDialogState() {
    _isShowDialog = false;
    _message = null;
    _errorMessage = null;
    notifyListeners();
  }

  /// Check if there is success message
  ///
  /// @return bool
  bool get isSuccess => _message != null && _errorMessage == null;

  /// Update order detail status
  ///
  /// @param int orderId
  /// @param int bookId
  /// @param int status
  /// @param String? note
  ///
  /// @return Future<void>
  Future<void> updateOrderDetailStatus({
    required int orderId,
    required int bookId,
    required int status,
    String? note,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _message = null;
    _isShowDialog = false;
    notifyListeners();

    final response = await updateBookOrderUseCase(
      UpdateBookInOrderParam(
        orderId: orderId,
        bookId: bookId,
        status: status,
        note: note,
      ),
    );

    if (response.success) {
      _message = response.data ?? 'Cập nhật trạng thái thành công';

      await getOrdersDetails(orderId);
    } else {
      if (response.errors is Map) {
        _errorMessage = response.errors['error_message']?.toString() ?? 'Đã có lỗi xảy ra';
      } else {
        _errorMessage = response.errors?.toString() ?? 'Đã có lỗi xảy ra';
      }
    }

    _isShowDialog = true;
    _isLoading = false;
    notifyListeners();
  }
}
