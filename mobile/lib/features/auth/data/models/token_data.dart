import 'package:json_annotation/json_annotation.dart';
part 'token_data.g.dart';

@JsonSerializable()
class TokenData {
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'token_type')
  final String tokenType;
  @JsonKey(name: 'expires_in')
  final int expiresIn;

  TokenData({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory TokenData.fromJson(Map<String, dynamic> json) =>
      _$TokenDataFromJson(json);

  Map<String, dynamic> toJson() => _$TokenDataToJson(this);
}
