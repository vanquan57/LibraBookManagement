// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wishlist _$WishlistFromJson(Map<String, dynamic> json) => Wishlist(
      book: Book.fromJson(json[''] as Map<String, dynamic>),
      pivot: json['pivot'] == null
          ? null
          : PivotUserWishlist.fromJson(json['pivot'] as Map<String, dynamic>),
      publisher: json['publisher'] == null
          ? null
          : Publisher.fromJson(json['publisher'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WishlistToJson(Wishlist instance) => <String, dynamic>{
      '': instance.book,
      'pivot': instance.pivot,
      'publisher': instance.publisher,
    };
