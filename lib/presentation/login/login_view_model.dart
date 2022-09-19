import 'package:clean_architecture_with_mvvm/presentation/base_view_model/base_view_model.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutput {
  // ................ input ................
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => throw UnimplementedError();

  @override
  // TODO: implement inputUsername
  Sink get inputUsername => throw UnimplementedError();

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  serPasswrd(String password) {
    // TODO: implement serPasswrd
    throw UnimplementedError();
  }

  @override
  setUserName(String userName) {
    // TODO: implement setUserName
    throw UnimplementedError();
  }

  //................ output...................

  @override
  // TODO: implement outputIsPasswordValid
  Stream<bool> get outputIsPasswordValid => throw UnimplementedError();

  @override
  // TODO: implement outputIsUsernameValid
  Stream<bool> get outputIsUsernameValid => throw UnimplementedError();
}

abstract class LoginViewModelInput {
  // function
  setUserName(String userName);
  serPasswrd(String password);
  login();

  // sink
  Sink get inputUsername;
  Sink get inputPassword;
}

abstract class LoginViewModelOutput {
  Stream<bool> get outputIsUsernameValid;
  Stream<bool> get outputIsPasswordValid;
}
