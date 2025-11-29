import 'package:json_annotation/json_annotation.dart';
part 'image.g.dart';

@JsonSerializable()
class BookImage {
  final int id;
  @JsonKey(name: 'book_id')
  final int bookId;
  final String url;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  BookImage({
    required this.id,
    required this.bookId,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookImage.fromJson(Map<String, dynamic> json) =>
      _$BookImageFromJson(json);
  Map<String, dynamic> toJson() => _$BookImageToJson(this);
}
