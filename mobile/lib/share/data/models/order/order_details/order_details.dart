import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/share/data/models/book/book.dart';
import 'package:mobile/share/data/models/order/order_details/pivot/pivot_order_book.dart';

part 'order_details.g.dart';

@JsonSerializable()
class OrderDetails {
  @JsonKey(name: '')
  final Book book;
  final PivotOrderBook? pivotOrderBooks;

  OrderDetails({required this.book, this.pivotOrderBooks});

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      book: Book.fromJson(json),
      pivotOrderBooks: json['pivot'] != null
          ? PivotOrderBook.fromJson(json['pivot'])
          : null,
    );
  }
  Map<String, dynamic> toJson() => _$OrderDetailsToJson(this);
}
