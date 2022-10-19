class LoginRequest {
  String email;
  String password;
  String imei;
  LoginRequest(this.email, this.password, this.imei);
}

class ForgotRequst {
  final String email;
  ForgotRequst(this.email);
}

class RegisterRequest {
  String firstName;
  String lastName;
  String email;
  String password;
  String imei;
  RegisterRequest(this.firstName,this.lastName, this.email, this.password, this.imei);
}
