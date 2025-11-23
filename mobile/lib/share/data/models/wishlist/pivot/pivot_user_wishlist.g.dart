// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pivot_user_wishlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PivotUserWishlist _$PivotUserWishlistFromJson(Map<String, dynamic> json) =>
    PivotUserWishlist(
      userId: (json['user_id'] as num).toInt(),
      bookId: (json['book_id'] as num).toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$PivotUserWishlistToJson(PivotUserWishlist instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'book_id': instance.bookId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
