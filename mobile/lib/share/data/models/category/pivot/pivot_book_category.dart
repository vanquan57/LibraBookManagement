import 'package:json_annotation/json_annotation.dart';
part 'pivot_book_category.g.dart';

@JsonSerializable()
class PivotBookCategory {
  @JsonKey(name: 'book_id')
  final int bookId; 
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  PivotBookCategory({
    required this.bookId,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PivotBookCategory.fromJson(Map<String, dynamic> json) => _$PivotBookCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$PivotBookCategoryToJson(this);
}
