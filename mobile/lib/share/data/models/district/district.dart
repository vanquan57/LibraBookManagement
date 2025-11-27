import 'package:json_annotation/json_annotation.dart';
part 'district.g.dart';

@JsonSerializable()
class District {
  final int id;
  final String? code;
  @JsonKey(name: 'province_code')
  final String? provinceCode;
  final String name;
  final String? createdAt;
  final String? updatedAt;

  District({
    required this.id,
    this.code,
    this.provinceCode,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory District.fromJson(Map<String, dynamic> json) => _$DistrictFromJson(json);
  Map<String, dynamic> toJson() => _$DistrictToJson(this);
}
