// convert the response into a non nullable object (model)

import 'package:clean_architecture_with_mvvm/app/extensions.dart';
import 'package:clean_architecture_with_mvvm/data/responses/response.dart';
import 'package:clean_architecture_with_mvvm/domain/model/model.dart';

// ignore: constant_identifier_names
const EMPTY = "";
// ignore: constant_identifier_names
const ZERO = 0;
// ignore: constant_identifier_names
const DOUBLE_ZERO = 0.0;

//....... USER ...........
extension UserResponseMapper on UserResponse? {
  User toDomain() {
    return User(
      this?.id?.orEmpty() ?? ZERO,
      this?.firstName?.orEmpty() ?? EMPTY,
      this?.lastName?.orEmpty() ?? EMPTY,
      this?.role?.orEmpty() ?? EMPTY,
      this?.email?.orEmpty() ?? EMPTY,
      this?.phone?.orEmpty() ?? EMPTY,
      this?.balance?.orEmpty() ?? EMPTY,
      this?.currencyCode?.orEmpty() ?? EMPTY,
      this?.lat?.orEmpty() ?? DOUBLE_ZERO,
      this?.lng?.orEmpty() ?? DOUBLE_ZERO,
      this?.image?.orEmpty() ?? EMPTY,
      this?.token?.orEmpty() ?? EMPTY,
    );
  }
}

//....... AUTHENTICATION ...........

extension AuthenticationMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.userResponse?.toDomain());
  }
}

//....... Base response ...........

extension BaseResponseMapper on BaseResponse? {
  Messages toDomain() {
    return Messages(this?.message ?? EMPTY);
  }
}

//........ Restaurant Item .........

extension RestaurantMapper on RestaurantResponse? {
  Restaurant toDomain() {
    return Restaurant(
        this?.id.orEmpty() ?? ZERO,
        this?.title.orEmpty() ?? EMPTY,
        this?.image.orEmpty() ?? EMPTY,
        this?.averageRatingTime.orEmpty() ?? ZERO);
  }
}

extension RestaurantDataMapper on RestaurantDataResponse? {
  RestaurantData toDomain() {
    List<Restaurant> restaurant =
        (this?.restaurantData?.map((service) => service.toDomain()) ??
                const Iterable.empty())
            .cast<Restaurant>()
            .toList();
    return RestaurantData(restaurant);
  }
}

extension RestauranResultMapper on RestaurantResultResponse? {
  RestaurantResult toDomain() {
    //   RestaurantData restaurantDatam= this?.restaurantData.toDomain()??RestaurantData([]);

    RestaurantData? restaurant = (this?.restaurantData?.toDomain());

    return RestaurantResult(restaurant!);
  }
}

//........ Restaurant Details .........

//....... USER ...........
extension RestaurantDetailMapper on RestaurantDetailsResponse? {
  RestaurantDetails toDomain() {
    return RestaurantDetails(
        this?.id.orEmpty() ?? ZERO,
        this?.ownerId.orEmpty() ?? ZERO,
        this?.categoryId.orEmpty() ?? ZERO,
        this?.cityId.orEmpty() ?? ZERO,
        this?.countryId.orEmpty() ?? ZERO,
        this?.title.orEmpty() ?? EMPTY,
        this?.address.orEmpty() ?? EMPTY,
        this?.latitude.orEmpty() ?? EMPTY,
        this?.longitude.orEmpty() ?? EMPTY,
        this?.thumbnail.orEmpty() ?? EMPTY,
        this?.avgDeliveryTime.orEmpty() ?? ZERO,
        this?.avgSiteRating.orEmpty() ?? ZERO,
        this?.about.orEmpty() ?? EMPTY);
  }
}

//....... AUTHENTICATION ...........

extension RestaurantDetailResultMapper on RestaurantDetailResultResponse? {
  RestaurantDetailsResult toDomain() {
    return RestaurantDetailsResult(this?.userResponse?.toDomain());
  }
}
