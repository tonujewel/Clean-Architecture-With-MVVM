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

  final StreamController _isAllInputValidateStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject('', '');

  LoginUseCase? _loginUseCase; // TODO: REMOVE ? MARK

  LoginViewModel(this._loginUseCase);

  // ................ INPUT ................
  @override
  void dispose() {
    _passwordStreamController.close();
    _userNameStreamController.close();
    _isAllInputValidateStreamController.close();
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
  Sink get inputIsAllInputValid => _isAllInputValidateStreamController.sink;

  @override
  login() async {
    // (await _loginUseCase.execute(
    //         LoginUseCaseInput(loginObject.username, loginObject.password)))
    //     .fold(
    //         (failure) => {
    //               // left -> failure
    //               print(failure.message)
    //             },
    //         (data) => {
    //               // right -> success
    //               print(data.user?.firstName)
    //             });
  }

  @override
  setPasswrd(String password) {
    inputPassword.add(password);
    loginObject.copyWith(password: password); // data class as kotlin
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUsername.add(userName);
    loginObject.copyWith(username: userName); // data class as kotlin
   _validate();
  }

  //................ OUTPUT...................

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isValidPassword(password));

  @override
  Stream<bool> get outputIsUsernameValid => _userNameStreamController.stream
      .map((username) => _isValidUserName(username));

  @override
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputValidateStreamController.stream.map((_) => _isAllInputValid());

  //................ PRIVATE...................

  bool _isValidPassword(String password) {
    return password.isNotEmpty;
  }

  bool _isValidUserName(String username) {
    return username.isNotEmpty;
  }

  bool _isAllInputValid() {
    return _isValidPassword(loginObject.password) &&
        _isValidUserName(loginObject.username);
  }


  _validate(){
    inputIsAllInputValid.add(null);
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
  Sink get inputIsAllInputValid;
}

abstract class LoginViewModelOutput {
  Stream<bool> get outputIsUsernameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputValid;
}
