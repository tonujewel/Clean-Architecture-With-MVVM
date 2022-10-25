class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

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

class Authentication {
  User? user;

  Authentication(this.user);
}

class Messages {
  String message;

  Messages(this.message);
}

class DeviceInfo {
  String name;
  String identifier;
  String version;

  DeviceInfo(this.name, this.identifier, this.version);
}

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
