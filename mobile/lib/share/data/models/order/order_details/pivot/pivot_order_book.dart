import 'package:json_annotation/json_annotation.dart';
part 'pivot_order_book.g.dart';

@JsonSerializable()
class PivotOrderBook {
  @JsonKey(name: 'order_id')    
  final int orderId; 
  @JsonKey(name: 'book_id')
  final int bookId;
  final int id;
  @JsonKey(name: 'borrow_date')
  final String borrowDate;
  @JsonKey(name: 'return_date')
  final String returnDate;
  final int quantity;
  final String? note;
  final int status;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  PivotOrderBook({
    required this.orderId,
    required this.bookId,
    required this.id,
    required this.borrowDate,
    required this.returnDate,
    required this.quantity,
    this.note,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PivotOrderBook.fromJson(Map<String, dynamic> json) => _$PivotOrderBookFromJson(json);
  Map<String, dynamic> toJson() => _$PivotOrderBookToJson(this);
}
