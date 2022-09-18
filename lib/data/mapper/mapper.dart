// convert the response into a non nullable object (model)

import 'package:clean_architecture_with_mvvm/app/extensions.dart';
import 'package:clean_architecture_with_mvvm/data/responses/response.dart';
import 'package:clean_architecture_with_mvvm/domain/model.dart';

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
