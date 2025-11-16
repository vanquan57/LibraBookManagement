import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/share/data/models/author/author.dart';
part 'book.g.dart';

@JsonSerializable()
class Book {
  final int id;
  @JsonKey(name: 'author_id')
  final int authorId;
  final String name;
  final String image;
  @JsonKey(name: 'feedbacks_count')
  final int feedbacksCount;
  @JsonKey(name: 'average_star')
  final int averageStar;
  final Author author;

  Book({
    required this.id,
    required this.authorId,
    required this.name,
    required this.image,
    required this.feedbacksCount,
    required this.averageStar,
    required this.author,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}
