// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      book: Book.fromJson(json[''] as Map<String, dynamic>),
      pivot: json['pivot'] == null
          ? null
          : PivotUserCart.fromJson(json['pivot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      '': instance.book,
      'pivot': instance.pivot,
    };
