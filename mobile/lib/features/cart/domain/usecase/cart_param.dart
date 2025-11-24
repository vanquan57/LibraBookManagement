// Class contain cart parameters.
import 'package:equatable/equatable.dart';

class CartParam extends Equatable {
  final int bookId;
  final int quantity;

  const CartParam({required this.bookId, required this.quantity});

  @override
  List<Object?> get props => [bookId, quantity];

  Map<String, dynamic> toJson() {
    return {'book_id': bookId, 'quantity': quantity};
  }
}
