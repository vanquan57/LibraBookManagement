import 'package:json_annotation/json_annotation.dart';
part 'pivot_user_cart.g.dart';

@JsonSerializable()
class PivotUserCart {
  @JsonKey(name: 'user_id')
  final int userId; 
  @JsonKey(name: 'book_id')
  final int bookId;
  final int quantity;
  final String? createdAt;
  final String? updatedAt;

  PivotUserCart({
    required this.userId,
    required this.bookId,
    required this.quantity,
    this.createdAt,
    this.updatedAt,
  });

  factory PivotUserCart.fromJson(Map<String, dynamic> json) => _$PivotUserCartFromJson(json);
  Map<String, dynamic> toJson() => _$PivotUserCartToJson(this);
}
