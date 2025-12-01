import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/order/domain/repositories/order_repository.dart';
import 'package:mobile/share/data/models/order/order.dart' as OrderModel;

@lazySingleton
class GetOrderDetailsUseCase { 
  final OrderRepository repository;

  // SYNC constructor
  GetOrderDetailsUseCase(this.repository);

  /// Get order details
  ///
  /// @param int orderId
  ///
  /// @return ApiResponse<OrderModel.Order>
  Future<ApiResponse<OrderModel.Order>> call(int orderId) async {
    return await repository.getOrderDetails(orderId);  
  }
}
