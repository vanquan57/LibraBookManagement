import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/share/data/models/order/order_details/order_details.dart';
import 'package:mobile/share/data/models/order/user_order/user_order.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  final int? id;
  @JsonKey(name: 'user_id')
  final int userId;
  final String code;
  final String email;
  final String phone;
  @JsonKey(name: 'province_id')
  final int provinceId;
  @JsonKey(name: 'district_id')
  final int districtId;
  @JsonKey(name: 'ward_id')
  final int wardId;
  final String address;
  final int status;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'order_details_count')
  final int? orderDetailsCount;
  final UserOrder? user;
  @JsonKey(name: 'order_details')
  final List<OrderDetails>? orderDetails;

  Order({   
    required this.id,
    required this.userId,
    required this.code,
    required this.email,
    required this.phone,
    required this.provinceId,
    required this.districtId,
    required this.wardId,
    required this.address,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.orderDetailsCount,
    this.user,
    this.orderDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) =>
      _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
