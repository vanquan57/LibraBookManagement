import 'package:json_annotation/json_annotation.dart';
part 'pivot_user_feedback.g.dart';

@JsonSerializable()
class PivotUserFeedback {
  @JsonKey(name: 'book_id')
  final int bookId;
  @JsonKey(name: 'user_id')
  final int userId;
  final String content;
  final int star;
  final int status;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  PivotUserFeedback({
    required this.bookId,
    required this.userId,
    required this.content,
    required this.star,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PivotUserFeedback.fromJson(Map<String, dynamic> json) =>
      _$PivotUserFeedbackFromJson(json);
  Map<String, dynamic> toJson() => _$PivotUserFeedbackToJson(this);
}
