// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feedback _$FeedbackFromJson(Map<String, dynamic> json) => Feedback(
      user: User.fromJson(json[''] as Map<String, dynamic>),
      pivot: json['pivot'] == null
          ? null
          : PivotUserFeedback.fromJson(json['pivot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
      '': instance.user,
      'pivot': instance.pivot,
    };
