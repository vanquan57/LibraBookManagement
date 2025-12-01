import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/order/data/datasources/order/order_remote_datasource.dart';
import 'package:mobile/features/order/domain/repositories/order_repository.dart';
import 'package:mobile/features/order/domain/usecase/order/get_order.dart';
import 'package:mobile/features/order/domain/usecase/order/update_book_order.dart';
import 'package:mobile/share/data/models/order/order.dart' as OrderModel;
import 'package:mobile/share/data/models/paginated/paginated.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  // SYNC constructor
  OrderRepositoryImpl(this.remoteDataSource);

  /// Get list of orders
  ///
  /// @param OrderParams params
  ///
  /// @return ApiResponse<Paginated<Order>>
  @override
  Future<ApiResponse<Paginated<OrderModel.Order>>> getOrders(OrderParams params) async {
    return await remoteDataSource.getOrders(params);
  }

  /// Update status of book in order
  ///
  /// @param UpdateBookInOrderParam params
  ///
  /// @return ApiResponse<String>
  @override
  Future<ApiResponse<String>> updateBookInOrderStatus(UpdateBookInOrderParam params) async {
    return await remoteDataSource.updateBookInOrderStatus(params);
  }

  /// Get order details
  ///
  /// @param int orderId
  ///
  /// @return ApiResponse<OrderModel.Order>
  @override
  Future<ApiResponse<OrderModel.Order>> getOrderDetails(int orderId) async {
    return await remoteDataSource.getOrderDetails(orderId);
  }
}
