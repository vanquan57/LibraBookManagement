import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/share/data/models/category/pivot/pivot_book_category.dart';
part 'category.g.dart';

@JsonSerializable()
class Category {
  final int id;
  final String name;
  final String? slug;
  final String? description;
  final String? createdAt;
  final String? updatedAt;
  final PivotBookCategory? pivot;

  Category({
    required this.id,
    required this.name,
    this.slug,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
