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

// restaurant item
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

// restaurant data
@JsonSerializable()
class RestaurantDataResponse {
  @JsonKey(name: 'data')
  List<RestaurantResponse>? restaurantData;

  RestaurantDataResponse(this.restaurantData);

// toJson
  Map<String, dynamic> toJson() => _$RestaurantDataResponseToJson(this);

//fromJson
  factory RestaurantDataResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDataResponseFromJson(json);
}

// restaurant result
@JsonSerializable()
class RestaurantResultResponse extends BaseResponse {
  @JsonKey(name: 'result')
  RestaurantDataResponse? restaurantData;

  RestaurantResultResponse(this.restaurantData);

// toJson
  Map<String, dynamic> toJson() => _$RestaurantResultResponseToJson(this);

//fromJson
  factory RestaurantResultResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantResultResponseFromJson(json);
}



//........................... Store details.........................

@JsonSerializable()
class RestaurantDetailsResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "owner_id")
  int? ownerId;
  @JsonKey(name: "category_id")
  int? categoryId;
  @JsonKey(name: "city_id")
  int? cityId;
  @JsonKey(name: "country_id")
  int? countryId;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "latitude")
  String? latitude;
  @JsonKey(name: "longitude")
  String? longitude;
  @JsonKey(name: "thumbnail")
  String? thumbnail;
  @JsonKey(name: "avg_delivery_time")
  int? avgDeliveryTime;
  @JsonKey(name: "avg_site_rating")
  int? avgSiteRating;
  @JsonKey(name: "about")
  String? about;

  RestaurantDetailsResponse(
    this.id,
    this.ownerId,
    this.categoryId,
    this.cityId,
    this.countryId,
    this.title,
    this.address,
    this.latitude,
    this.longitude,
    this.thumbnail,
    this.avgDeliveryTime,
    this.avgSiteRating,
    this.about

  );
  // from json
  factory RestaurantDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailsResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$RestaurantDetailsResponseToJson(this);
}

@JsonSerializable()
class RestaurantDetailResultResponse extends BaseResponse {
  @JsonKey(name: "result")
  RestaurantDetailsResponse? userResponse;

  RestaurantDetailResultResponse(this.userResponse);

  // from json
  factory RestaurantDetailResultResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailResultResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$RestaurantDetailResultResponseToJson(this);
}


