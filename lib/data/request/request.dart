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
