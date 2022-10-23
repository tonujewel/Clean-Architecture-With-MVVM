import 'dart:async';
import 'dart:math';
import 'package:clean_architecture_with_mvvm/app/functions.dart';
import 'package:clean_architecture_with_mvvm/domain/use_case/register_use_case.dart';
import 'package:clean_architecture_with_mvvm/presentation/base_view_model/base_view_model.dart';
import 'package:clean_architecture_with_mvvm/presentation/common/freezed_data_classes.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  final StreamController _firstNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _lastNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputValidStreamController =
      StreamController<String>.broadcast();

  RegisterUseCase _registerUseCase;
  var registerViewObject = RegisterObject('', '', '', '');
  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _firstNameStreamController.close();
    _lastNameStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _isAllInputValidStreamController.close();

    super.dispose();
  }

  // .... INPUT......

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputFirstName => _firstNameStreamController.sink;

  @override
  Sink get inputLastName => _lastNameStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  register() {
    throw UnimplementedError();
  }

  // .... OUTPUT ......

  // first name =====>
  @override
  Stream<bool> get outputIsFirstNameValid => _firstNameStreamController.stream
      .map((firstName) => _isFirstNameValid(firstName));

  @override
  Stream<String?> get outputErrorFirstName => outputIsFirstNameValid.map(
      (isFirstNameValid) => isFirstNameValid ? null : "Invalid first name");

// last name ====>
  @override
  Stream<bool> get outputIsLastNameValid => _lastNameStreamController.stream
      .map((lastName) => _isLastNameValid(lastName));

  @override
  Stream<String?> get outputErrorLastName => outputIsLastNameValid
      .map((isLastNameValid) => isLastNameValid ? null : "Invalid last name");

// email  ====>
  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isValidEmail(email));

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : "Invalid email");

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid
      .map((isPasswordValid) => isPasswordValid ? null : "Invalid password");

  //........... private function ............

  bool _isFirstNameValid(String firstName) {
    return firstName.isNotEmpty;
  }

  bool _isLastNameValid(String lastName) {
    return lastName.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }
}

abstract class RegisterViewModelInput {
  register();

  Sink get inputFirstName;
  Sink get inputLastName;
  Sink get inputEmail;
  Sink get inputPassword;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsFirstNameValid;
  Stream<String?> get outputErrorFirstName;

  Stream<bool> get outputIsLastNameValid;
  Stream<String?> get outputErrorLastName;
  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;
  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;
}
