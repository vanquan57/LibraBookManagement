// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookImage _$BookImageFromJson(Map<String, dynamic> json) => BookImage(
      id: (json['id'] as num).toInt(),
      bookId: (json['book_id'] as num).toInt(),
      url: json['url'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$BookImageToJson(BookImage instance) => <String, dynamic>{
      'id': instance.id,
      'book_id': instance.bookId,
      'url': instance.url,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
