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
      json['name'] as String?,
      json['image'] as String?,
      json['price'] as int?,
    );

Map<String, dynamic> _$RestaurantResponseToJson(RestaurantResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.title,
      'image': instance.image,
      'price': instance.price,
    };

RestaurantDataResponse _$RestaurantDataResponseFromJson(
        Map<String, dynamic> json) =>
    RestaurantDataResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => RestaurantResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$RestaurantDataResponseToJson(
        RestaurantDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.restaurantData,
    };
