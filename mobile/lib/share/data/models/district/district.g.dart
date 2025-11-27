// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

District _$DistrictFromJson(Map<String, dynamic> json) => District(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String?,
      provinceCode: json['province_code'] as String?,
      name: json['name'] as String,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$DistrictToJson(District instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'province_code': instance.provinceCode,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
