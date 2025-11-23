import 'package:json_annotation/json_annotation.dart';
part 'pivot_user_wishlist.g.dart';

@JsonSerializable()
class PivotUserWishlist {
  @JsonKey(name: 'user_id')
  final int userId; 
  @JsonKey(name: 'book_id')
  final int bookId;
  final String? createdAt;
  final String? updatedAt;

  PivotUserWishlist({
    required this.userId,
    required this.bookId,
    this.createdAt,
    this.updatedAt,
  });

  factory PivotUserWishlist.fromJson(Map<String, dynamic> json) => _$PivotUserWishlistFromJson(json);
  Map<String, dynamic> toJson() => _$PivotUserWishlistToJson(this);
}
