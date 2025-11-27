import 'package:json_annotation/json_annotation.dart';
part 'province.g.dart';

@JsonSerializable()
class Province {
  final int id;
  final String? code;
  final String name;
  final String? createdAt;
  final String? updatedAt;

  Province({
    required this.id,
    this.code,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Province.fromJson(Map<String, dynamic> json) => _$ProvinceFromJson(json);
  Map<String, dynamic> toJson() => _$ProvinceToJson(this);
}
