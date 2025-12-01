import 'package:json_annotation/json_annotation.dart';

part 'user_order.g.dart';

@JsonSerializable()
class UserOrder {
  final int id;
  final String name;
  final String email;

  UserOrder({required this.id, required this.name, required this.email});

  factory UserOrder.fromJson(Map<String, dynamic> json) =>
      _$UserOrderFromJson(json);
  Map<String, dynamic> toJson() => _$UserOrderToJson(this);
}
