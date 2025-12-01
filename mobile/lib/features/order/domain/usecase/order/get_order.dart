import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/order/domain/repositories/order_repository.dart';
import 'package:mobile/share/data/models/order/order.dart' as OrderModel;
import 'package:mobile/share/data/models/paginated/paginated.dart';

@lazySingleton
class GetOrderUseCase {
  final OrderRepository repository;

  // SYNC constructor
  GetOrderUseCase(this.repository);

  /// Get list of orders
  ///
  /// @param OrderParams params
  ///
  /// @return ApiResponse<Paginated<OrderModel.Order>>
  Future<ApiResponse<Paginated<OrderModel.Order>>> call(OrderParams params) async {
    return await repository.getOrders(params);
  }
}

// Class contain order parameters.
class OrderParams extends Equatable {
  final int page;
  final int? limit;
  final String? column;
  final String? order;
  final String? startDate;
  final String? endDate;
  final int? status;

  const OrderParams({
    required this.page,
    this.limit,
    this.column,
    this.order,
    this.startDate,
    this.endDate,
    this.status,
  });

  @override
  List<Object?> get props => [
    page,
    limit,
    column,
    order,
    startDate,
    endDate,
    status,
  ];
}
