// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pivot_user_feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PivotUserFeedback _$PivotUserFeedbackFromJson(Map<String, dynamic> json) =>
    PivotUserFeedback(
      bookId: (json['book_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      content: json['content'] as String,
      star: (json['star'] as num).toInt(),
      status: (json['status'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$PivotUserFeedbackToJson(PivotUserFeedback instance) =>
    <String, dynamic>{
      'book_id': instance.bookId,
      'user_id': instance.userId,
      'content': instance.content,
      'star': instance.star,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
