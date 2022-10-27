// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..success = json['success'] as bool?
  ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      json['id'] as int?,
      json['first_name'] as String?,
      json['last_name'] as String?,
      json['role'] as String?,
      json['email'] as String?,
      json['phone'] as String?,
      json['balance'] as String?,
      json['currency_code'] as String?,
      (json['lat'] as num?)?.toDouble(),
      (json['lng'] as num?)?.toDouble(),
      json['image'] as String?,
      json['token'] as String?,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'role': instance.role,
      'email': instance.email,
      'phone': instance.phone,
      'balance': instance.balance,
      'currency_code': instance.currencyCode,
      'lat': instance.lat,
      'lng': instance.lng,
      'image': instance.image,
      'token': instance.token,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      json['data'] == null
          ? null
          : UserResponse.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.userResponse,
    };

RestaurantResponse _$RestaurantResponseFromJson(Map<String, dynamic> json) =>
    RestaurantResponse(
      json['id'] as int?,
      json['title'] as String?,
      json['thumbnail'] as String?,
      json['avg_delivery_time'] as int?,
    );

Map<String, dynamic> _$RestaurantResponseToJson(RestaurantResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'thumbnail': instance.image,
      'avg_delivery_time': instance.averageRatingTime,
    };

RestaurantDataResponse _$RestaurantDataResponseFromJson(
        Map<String, dynamic> json) =>
    RestaurantDataResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => RestaurantResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestaurantDataResponseToJson(
        RestaurantDataResponse instance) =>
    <String, dynamic>{
      'data': instance.restaurantData,
    };

RestaurantResultResponse _$RestaurantResultResponseFromJson(
        Map<String, dynamic> json) =>
    RestaurantResultResponse(
      json['result'] == null
          ? null
          : RestaurantDataResponse.fromJson(
              json['result'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$RestaurantResultResponseToJson(
        RestaurantResultResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'result': instance.restaurantData,
    };

RestaurantDetailsResponse _$RestaurantDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    RestaurantDetailsResponse(
      json['id'] as int?,
      json['owner_id'] as int?,
      json['category_id'] as int?,
      json['city_id'] as int?,
      json['country_id'] as int?,
      json['title'] as String?,
      json['address'] as String?,
      json['latitude'] as String?,
      json['longitude'] as String?,
      json['thumbnail'] as String?,
      json['avg_delivery_time'] as int?,
      json['avg_site_rating'] as int?,
      json['about'] as String?,
    );

Map<String, dynamic> _$RestaurantDetailsResponseToJson(
        RestaurantDetailsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner_id': instance.ownerId,
      'category_id': instance.categoryId,
      'city_id': instance.cityId,
      'country_id': instance.countryId,
      'title': instance.title,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'thumbnail': instance.thumbnail,
      'avg_delivery_time': instance.avgDeliveryTime,
      'avg_site_rating': instance.avgSiteRating,
      'about': instance.about,
    };

RestaurantDetailResultResponse _$RestaurantDetailResultResponseFromJson(
        Map<String, dynamic> json) =>
    RestaurantDetailResultResponse(
      json['result'] == null
          ? null
          : RestaurantDetailsResponse.fromJson(
              json['result'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$RestaurantDetailResultResponseToJson(
        RestaurantDetailResultResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'result': instance.userResponse,
    };
