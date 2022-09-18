import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class UserResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "last_name")
  String? lastName;
  @JsonKey(name: "role")
  String? role;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "balance")
  String? balance;
  @JsonKey(name: "currency_code")
  String? currencyCode;
  @JsonKey(name: "lat")
  double? lat;
  @JsonKey(name: "lng")
  double? lng;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "token")
  String? token;
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "data")
  UserResponse? userResponse;
}
