// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      id: (json['id'] as num).toInt(),
      authorId: (json['author_id'] as num).toInt(),
      publisherId: (json['publisher_id'] as num?)?.toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String?,
      miniDescription: json['mini_description'] as String?,
      detailsDescription: json['details_description'] as String?,
      publicationDate: json['publication_date'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      size: json['size'] as String?,
      page: (json['page'] as num?)?.toInt(),
      coverType: (json['cover_type'] as num?)?.toInt(),
      views: (json['views'] as num?)?.toInt(),
      borrowingNumber: (json['borrowing_number'] as num?)?.toInt(),
      image: json['image'] as String,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      feedbacksCount: (json['feedbacks_count'] as num?)?.toInt(),
      averageStar: (json['average_star'] as num?)?.toInt(),
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      publisher: json['publisher'] == null
          ? null
          : Publisher.fromJson(json['publisher'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'author_id': instance.authorId,
      'publisher_id': instance.publisherId,
      'name': instance.name,
      'slug': instance.slug,
      'mini_description': instance.miniDescription,
      'details_description': instance.detailsDescription,
      'publication_date': instance.publicationDate,
      'quantity': instance.quantity,
      'size': instance.size,
      'page': instance.page,
      'cover_type': instance.coverType,
      'views': instance.views,
      'borrowing_number': instance.borrowingNumber,
      'image': instance.image,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'feedbacks_count': instance.feedbacksCount,
      'average_star': instance.averageStar,
      'author': instance.author,
      'publisher': instance.publisher,
    };
