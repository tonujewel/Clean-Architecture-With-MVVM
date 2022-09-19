import 'dart:async';

import 'package:clean_architecture_with_mvvm/domain/use_case/login_use_case.dart';
import 'package:clean_architecture_with_mvvm/presentation/base_view_model/base_view_model.dart';
import 'package:clean_architecture_with_mvvm/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  var loginObject = LoginObject('', '');

  LoginUseCase ?_loginUseCase;  // TODO: REMOVE ? MARK

  LoginViewModel(this._loginUseCase);

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
  login() async {
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.username, loginObject.password)))
        .fold(
            (failure) => {
                  // left -> failure
                  print(failure.message)
                },
            (data) => {
                  // right -> success
                  print(data.user?.firstName)
                });
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
