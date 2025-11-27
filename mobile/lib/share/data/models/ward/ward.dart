import 'package:json_annotation/json_annotation.dart';
part 'ward.g.dart';

@JsonSerializable()
class Ward {
  final int id;
  final String? code;
  @JsonKey(name: 'district_code')
  final String? districtCode;
  final String name;
  final String? createdAt;
  final String? updatedAt;

  Ward({
    required this.id,
    this.code,
    this.districtCode,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Ward.fromJson(Map<String, dynamic> json) => _$WardFromJson(json);
  Map<String, dynamic> toJson() => _$WardToJson(this);
}
