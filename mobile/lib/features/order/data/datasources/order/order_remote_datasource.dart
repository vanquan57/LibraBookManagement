import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/helper/error_parser.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/order/domain/usecase/order/get_order.dart';
import 'package:mobile/features/order/domain/usecase/order/update_book_order.dart';
import 'package:mobile/share/data/models/order/order.dart' as OrderModel;
import 'package:mobile/share/data/models/paginated/paginated.dart';

@lazySingleton
class OrderRemoteDataSource {
  final Dio _dio;

  OrderRemoteDataSource(this._dio);

  /// Get list of orders
  ///
  /// @param OrderParams params
  ///
  /// @return ApiResponse<Paginated<Order>>
  Future<ApiResponse<Paginated<OrderModel.Order>>> getOrders(
    OrderParams params,
  ) async {
    try {
      final queryParameters = <String, dynamic>{};

      queryParameters['page'] = params.page;
      if (params.limit != null) queryParameters['limit'] = params.limit;
      if (params.column != null) queryParameters['column'] = params.column;
      if (params.order != null) queryParameters['order'] = params.order;
      if (params.startDate != null)queryParameters['start_date'] = params.startDate;
      if (params.endDate != null) queryParameters['end_date'] = params.endDate;
      if (params.status != null) queryParameters['status'] = params.status;

      final response = await _dio.get(
        '/order',
        queryParameters: queryParameters,
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => Paginated<OrderModel.Order>.fromJson(
          json as Map<String, dynamic>,
          (json) => OrderModel.Order.fromJson(json as Map<String, dynamic>),
        ),
      );
    } on DioException catch (e) {
      log.e('Get orders failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Get orders failed w: $e');

      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }

  /// Update status of book in order
  ///
  /// @param UpdateBookInOrderParam params
  ///
  /// @return ApiResponse<String>
  Future<ApiResponse<String>> updateBookInOrderStatus(UpdateBookInOrderParam params) async {
    try {
      final response = await _dio.put('/order/${params.orderId}', data: params.toJson());  

      return ApiResponse.fromJson(
        response.data,
        (json) => json['message'] as String,
      );
    } on DioException catch (e) {
      log.e('Update order status failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Update order status failed w: $e');

      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }

  /// Get the user's wishlist
  ///
  /// @param int orderId
  ///
  /// @return ApiResponse<OrderModel.Order>
  Future<ApiResponse<OrderModel.Order>> getOrderDetails(int orderId) async {
    try {
      final response = await _dio.get('/order/$orderId');

      return ApiResponse<OrderModel.Order>.fromJson(
        response.data,
        (data) => OrderModel.Order.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      log.e('Get order details failed: ${getErrorMessage(e)}');

      return ApiResponse.failure(getErrorMessage(e));
    } catch (e) {
      log.e('Get order details failed w: $e');

      return ApiResponse.failure(
        'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại sau.',
      );
    }
  }
}
