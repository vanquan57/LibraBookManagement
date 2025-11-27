// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      emailVerifiedAt: json['email_verified_at'] as String?,
      role: (json['role'] as num).toInt(),
      googleId: json['google_id'] as String?,
      avatar: json['avatar'] as String?,
      provinceId: (json['province_id'] as num).toInt(),
      districtId: (json['district_id'] as num).toInt(),
      wardId: (json['ward_id'] as num).toInt(),
      address: json['address'] as String,
      status: (json['status'] as num).toInt(),
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      province: json['province'] == null
          ? null
          : Province.fromJson(json['province'] as Map<String, dynamic>),
      district: json['district'] == null
          ? null
          : District.fromJson(json['district'] as Map<String, dynamic>),
      ward: json['ward'] == null
          ? null
          : Ward.fromJson(json['ward'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'email': instance.email,
      'email_verified_at': instance.emailVerifiedAt,
      'role': instance.role,
      'google_id': instance.googleId,
      'avatar': instance.avatar,
      'province_id': instance.provinceId,
      'district_id': instance.districtId,
      'ward_id': instance.wardId,
      'address': instance.address,
      'status': instance.status,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'province': instance.province,
      'district': instance.district,
      'ward': instance.ward,
    };
