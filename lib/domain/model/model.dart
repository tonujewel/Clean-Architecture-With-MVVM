// SLIDER
class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

// USER
class User {
  int id;
  String firstName;
  String lastName;
  String role;
  String email;
  String phone;
  String balance;
  String currencyCode;
  double lat;
  double lng;
  String image;
  String token;

  User(
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
}

// AUTHENTICATION
class Authentication {
  User? user;

  Authentication(this.user);
}

// MESSAGE

class Messages {
  String message;

  Messages(this.message);
}

// DEVICE INFO
class DeviceInfo {
  String name;
  String identifier;
  String version;

  DeviceInfo(this.name, this.identifier, this.version);
}

// RESTAURANT
class Restaurant {
  int id;
  String name;
  String image;
  int price;

  Restaurant(this.id, this.name, this.image, this.price);
}

class RestaurantData {
  List<Restaurant> data;

  RestaurantData(this.data);
}

class RestaurantResult {
  RestaurantData restaurantData;

  RestaurantResult(this.restaurantData);
}

// RESTAURANT DETAILS
class RestaurantDetails {
  int id;
  int ownerId;
  int categoryId;
  int cityId;
  int countryId;
  String title;
  String address;
  String lattitude;
  String longitude;
  String thumbnail;
  int averageDeliverytime;
  int averageSiteRating;
  String about;

  RestaurantDetails(
    this.id,
    this.ownerId,
    this.categoryId,
    this.cityId,
    this.countryId,
    this.title,
    this.address,
    this.lattitude,
    this.longitude,
    this.thumbnail,
    this.averageDeliverytime,
    this.averageSiteRating,
    this.about
  );
}

// AUTHENTICATION
class RestaurantDetailsResult {
  RestaurantDetails? user;

  RestaurantDetailsResult(this.user);
}
