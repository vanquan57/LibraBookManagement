// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      id: (json['id'] as num).toInt(),
      authorId: (json['author_id'] as num).toInt(),
      name: json['name'] as String,
      image: json['image'] as String,
      feedbacksCount: (json['feedbacks_count'] as num).toInt(),
      averageStar: (json['average_star'] as num).toInt(),
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'author_id': instance.authorId,
      'name': instance.name,
      'image': instance.image,
      'feedbacks_count': instance.feedbacksCount,
      'average_star': instance.averageStar,
      'author': instance.author,
    };
