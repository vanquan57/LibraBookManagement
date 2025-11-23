// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publisher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Publisher _$PublisherFromJson(Map<String, dynamic> json) => Publisher(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$PublisherToJson(Publisher instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
