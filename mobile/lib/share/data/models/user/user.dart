import 'package:json_annotation/json_annotation.dart';
import '../province/province.dart';
import '../district/district.dart';
import '../ward/ward.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String code;
  final String name;
  final String email;
  @JsonKey(name: 'email_verified_at')
  final String? emailVerifiedAt;
  final int role;
  @JsonKey(name: 'google_id')
  final String? googleId;
  final String? avatar;
  @JsonKey(name: 'province_id')
  final int provinceId;
  @JsonKey(name: 'district_id')
  final int districtId;
  @JsonKey(name: 'ward_id')
  final int wardId;
  final String address;
  final int status;
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  final Province? province;
  final District? district;
  final Ward? ward;

  User({
    required this.id,
    required this.code,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.role,
    this.googleId,
    this.avatar,
    required this.provinceId,
    required this.districtId,
    required this.wardId,
    required this.address,
    required this.status,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    this.province,
    this.district,
    this.ward,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
