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
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'thumbnail')
  String? image;
  @JsonKey(name: 'avg_delivery_time')
  int? averageRatingTime;

  RestaurantResponse(this.id, this.title, this.image, this.averageRatingTime);

// toJson
  Map<String, dynamic> toJson() => _$RestaurantResponseToJson(this);

//fromJson
  factory RestaurantResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantResponseFromJson(json);
}

@JsonSerializable()
class RestaurantDataResponse  {
  @JsonKey(name: 'data')
  List<RestaurantResponse>? restaurantData;

  RestaurantDataResponse(this.restaurantData);

// toJson
  Map<String, dynamic> toJson() => _$RestaurantDataResponseToJson(this);

//fromJson
  factory RestaurantDataResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDataResponseFromJson(json);
}
@JsonSerializable()
class RestaurantResultResponse extends BaseResponse  {
  @JsonKey(name: 'result')
  RestaurantDataResponse? restaurantData;

  RestaurantResultResponse(this.restaurantData);

// toJson
  Map<String, dynamic> toJson() => _$RestaurantResultResponseToJson(this);

//fromJson
  factory RestaurantResultResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantResultResponseFromJson(json);
}
