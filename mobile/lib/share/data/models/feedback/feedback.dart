import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/share/data/models/feedback/pivot/pivot_user_feedback.dart';
import 'package:mobile/share/data/models/user/user.dart';

part 'feedback.g.dart';

@JsonSerializable()
class Feedback {
  @JsonKey(name: '')
  final User user;
  final PivotUserFeedback? pivot;

  Feedback({required this.user, this.pivot});

  factory Feedback.fromJson(Map<String, dynamic> json) {
    return Feedback(
      user: User.fromJson(json),
      pivot: json['pivot'] != null
          ? PivotUserFeedback.fromJson(json['pivot'])
          : null,
    );
  }
  Map<String, dynamic> toJson() => _$FeedbackToJson(this);
}
