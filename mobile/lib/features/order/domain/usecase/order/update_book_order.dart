import 'package:injectable/injectable.dart';
import 'package:mobile/core/response/api_response.dart';
import 'package:mobile/features/order/domain/repositories/order_repository.dart';

@lazySingleton
class UpdateBookOrderUseCase {
  final OrderRepository repository;

  // SYNC constructor
  UpdateBookOrderUseCase(this.repository);

  /// Update status of book in order
  ///
  /// @param UpdateBookInOrderParam params
  ///
  /// @return ApiResponse<String>
  Future<ApiResponse<String>> call(UpdateBookInOrderParam params) async {
    return await repository.updateBookInOrderStatus(params);
  }
}

class UpdateBookInOrderParam {
  final int orderId;
  final int bookId;
  final String? note;
  final int status;

  UpdateBookInOrderParam({
    required this.orderId,
    required this.bookId,
    this.note,
    required this.status,
  });

  @override
  List<Object?> get props => [orderId, bookId, note, status];

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'book_id': bookId,
      'note': note,
      'status': status,
    };
  }
}
