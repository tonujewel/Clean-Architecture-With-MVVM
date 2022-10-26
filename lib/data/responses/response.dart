import 'package:json_annotation/json_annotation.dart';
part 'response.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "message")
  String? message;

  static fromJson(Map<String, dynamic> map) {}
}

@JsonSerializable()
class UserResponse {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "first_name")
  final String? firstName;
  @JsonKey(name: "last_name")
  final String? lastName;
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "balance")
  final String? balance;
  @JsonKey(name: "currency_code")
  final String? currencyCode;
  @JsonKey(name: "lat")
  final double? lat;
  @JsonKey(name: "lng")
  final double? lng;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "token")
  final String? token;

  UserResponse(
    this.id,
    this.firstName,
    this.lastName,
    this.role,
    this.email,
    this.phone,
    this.balance,
    this.currencyCode,
    this.lat,
    this.lng,
    this.image,
    this.token,
  );
  // from json
  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "data")
  UserResponse? userResponse;

  AuthenticationResponse(this.userResponse);

  // from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class RestaurantResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? title;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'price')
  int? price;

  RestaurantResponse(this.id, this.title, this.image, this.price);

// toJson
  Map<String, dynamic> toJson() => _$RestaurantResponseToJson(this);

//fromJson
  factory RestaurantResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantResponseFromJson(json);
}

@JsonSerializable()
class RestaurantDataResponse extends BaseResponse {
  @JsonKey(name: 'result')
  List<RestaurantResponse>? restaurantData;

  RestaurantDataResponse(this.restaurantData);

// toJson
  Map<String, dynamic> toJson() => _$RestaurantDataResponseToJson(this);

//fromJson
  factory RestaurantDataResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDataResponseFromJson(json);
}
