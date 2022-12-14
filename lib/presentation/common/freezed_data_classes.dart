import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String username, String password) = _LoginObject;
}

@freezed
class ForgotObject with _$ForgotObject {
  factory ForgotObject(String email) = _ForgotObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(String firstName , String lastName,String email, String password, String profileImage) = _RegisterObjectt;
}
