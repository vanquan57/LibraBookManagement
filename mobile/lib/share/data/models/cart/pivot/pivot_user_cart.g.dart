// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pivot_user_cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PivotUserCart _$PivotUserCartFromJson(Map<String, dynamic> json) =>
    PivotUserCart(
      userId: (json['user_id'] as num).toInt(),
      bookId: (json['book_id'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$PivotUserCartToJson(PivotUserCart instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'book_id': instance.bookId,
      'quantity': instance.quantity,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
