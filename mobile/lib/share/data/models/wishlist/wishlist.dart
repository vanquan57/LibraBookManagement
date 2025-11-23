import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/share/data/models/book/book.dart';
import '../publisher/publisher.dart';
import 'pivot/pivot_user_wishlist.dart';

part 'wishlist.g.dart';

@JsonSerializable()
class Wishlist {
  @JsonKey(name: '')
  final Book book;
  final PivotUserWishlist? pivot;
  final Publisher? publisher;

  Wishlist({required this.book, this.pivot, this.publisher});

  factory Wishlist.fromJson(Map<String, dynamic> json) {
    return Wishlist(
      book: Book.fromJson(json),
      pivot: json['pivot'] != null
          ? PivotUserWishlist.fromJson(json['pivot'])
          : null,
    );
  }
  Map<String, dynamic> toJson() => _$WishlistToJson(this);
}
