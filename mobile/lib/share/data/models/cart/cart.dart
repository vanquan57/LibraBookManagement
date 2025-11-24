import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/share/data/models/book/book.dart';
import 'pivot/pivot_user_cart.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  @JsonKey(name: '')
  final Book book;
  final PivotUserCart? pivot;

  Cart({required this.book, this.pivot});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      book: Book.fromJson(json),
      pivot: json['pivot'] != null
          ? PivotUserCart.fromJson(json['pivot'])
          : null,
    );
  }
  Map<String, dynamic> toJson() => _$CartToJson(this);
}
