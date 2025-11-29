// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pivot_book_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PivotBookCategory _$PivotBookCategoryFromJson(Map<String, dynamic> json) =>
    PivotBookCategory(
      bookId: (json['book_id'] as num).toInt(),
      categoryId: (json['category_id'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$PivotBookCategoryToJson(PivotBookCategory instance) =>
    <String, dynamic>{
      'book_id': instance.bookId,
      'category_id': instance.categoryId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
