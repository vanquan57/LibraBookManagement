// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num).toInt(),
      code: json['code'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      provinceId: (json['province_id'] as num).toInt(),
      districtId: (json['district_id'] as num).toInt(),
      wardId: (json['ward_id'] as num).toInt(),
      address: json['address'] as String,
      status: (json['status'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      orderDetailsCount: (json['order_details_count'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : UserOrder.fromJson(json['user'] as Map<String, dynamic>),
      orderDetails: (json['order_details'] as List<dynamic>?)
          ?.map((e) => OrderDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'code': instance.code,
      'email': instance.email,
      'phone': instance.phone,
      'province_id': instance.provinceId,
      'district_id': instance.districtId,
      'ward_id': instance.wardId,
      'address': instance.address,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'order_details_count': instance.orderDetailsCount,
      'user': instance.user,
      'order_details': instance.orderDetails,
    };
