import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/order/domain/usecase/order/get_order.dart';
import 'package:mobile/features/order/domain/usecase/order/update_book_order.dart';
import 'package:mobile/share/data/models/order/order.dart' as OrderModel;
import 'package:mobile/share/data/models/paginated/paginated.dart';

abstract class OrderRepository {
  /// Get list of orders
  ///
  /// @param OrderParams params
  ///
  /// @return ApiResponse<Paginated<Order>>
  Future<ApiResponse<Paginated<OrderModel.Order>>> getOrders(OrderParams params);  

  /// Update status of book in order
  ///
  /// @param UpdateBookInOrderParam params
  ///
  /// @return ApiResponse<String>
  Future<ApiResponse<String>> updateBookInOrderStatus(UpdateBookInOrderParam params);

  /// Get order details
  ///
  /// @param int orderId
  ///
  /// @return ApiResponse<OrderModel.Order>
  Future<ApiResponse<OrderModel.Order>> getOrderDetails(int orderId);
}
