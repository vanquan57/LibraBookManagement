// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pivot_order_book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PivotOrderBook _$PivotOrderBookFromJson(Map<String, dynamic> json) =>
    PivotOrderBook(
      orderId: (json['order_id'] as num).toInt(),
      bookId: (json['book_id'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      borrowDate: json['borrow_date'] as String,
      returnDate: json['return_date'] as String,
      quantity: (json['quantity'] as num).toInt(),
      note: json['note'] as String?,
      status: (json['status'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$PivotOrderBookToJson(PivotOrderBook instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'book_id': instance.bookId,
      'id': instance.id,
      'borrow_date': instance.borrowDate,
      'return_date': instance.returnDate,
      'quantity': instance.quantity,
      'note': instance.note,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
