// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetails _$OrderDetailsFromJson(Map<String, dynamic> json) => OrderDetails(
      book: Book.fromJson(json[''] as Map<String, dynamic>),
      pivotOrderBooks: json['pivotOrderBooks'] == null
          ? null
          : PivotOrderBook.fromJson(
              json['pivotOrderBooks'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderDetailsToJson(OrderDetails instance) =>
    <String, dynamic>{
      '': instance.book,
      'pivotOrderBooks': instance.pivotOrderBooks,
    };
