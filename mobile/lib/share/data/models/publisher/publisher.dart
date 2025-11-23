import 'package:json_annotation/json_annotation.dart';
part 'publisher.g.dart';

@JsonSerializable()
class Publisher {
  final int id;
  final String name;
  final String? slug;
  final String? description;
  final String? createdAt;
  final String? updatedAt;

  Publisher({
    required this.id,
    required this.name,
    this.slug,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) => _$PublisherFromJson(json);
  Map<String, dynamic> toJson() => _$PublisherToJson(this);
}
