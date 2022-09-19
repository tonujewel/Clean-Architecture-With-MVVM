import 'dart:async';

import 'package:clean_architecture_with_mvvm/presentation/base_view_model/base_view_model.dart';
import 'package:clean_architecture_with_mvvm/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  var loginObject = LoginObject('', '');

  // ................ INPUT ................
  @override
  void dispose() {
    _passwordStreamController.close();
    _userNameStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUsername => _userNameStreamController.sink;

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  setPasswrd(String password) {
    inputPassword.add(password);
    loginObject.copyWith(password: password); // data class as kotlin
  }

  @override
  setUserName(String userName) {
    inputUsername.add(userName);
    loginObject.copyWith(username: userName); // data class as kotlin
  }

  //................ OUTPUT...................

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isValidPassword(password));

  @override
  Stream<bool> get outputIsUsernameValid => _userNameStreamController.stream
      .map((username) => _isValidUserName(username));

  //................ PRIVATE...................

  bool _isValidPassword(String password) {
    return password.isNotEmpty;
  }

  bool _isValidUserName(String username) {
    return username.isNotEmpty;
  }
}

abstract class LoginViewModelInput {
  // function
  setUserName(String userName);
  setPasswrd(String password);
  login();

  // sink
  Sink get inputUsername;
  Sink get inputPassword;
}

abstract class LoginViewModelOutput {
  Stream<bool> get outputIsUsernameValid;
  Stream<bool> get outputIsPasswordValid;
}
