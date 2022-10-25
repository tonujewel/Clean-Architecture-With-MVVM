import 'dart:async';
import 'dart:io';
import 'package:clean_architecture_with_mvvm/app/functions.dart';
import 'package:clean_architecture_with_mvvm/domain/use_case/register_use_case.dart';
import 'package:clean_architecture_with_mvvm/presentation/base_view_model/base_view_model.dart';
import 'package:clean_architecture_with_mvvm/presentation/common/freezed_data_classes.dart';

import '../common/state_renderer/state_render_impl.dart';
import '../common/state_renderer/state_renderer.dart';

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
  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  final StreamController<File> _profileStreamController =
      StreamController<File>.broadcast();

  StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  final RegisterUseCase _registerUseCase;
  var registerViewObject = RegisterObject('', '', '', '', '');
  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _registerUseCase.execute(RegisterUseCaseInput(
            registerViewObject.firstName,
            registerViewObject.lastName,
            registerViewObject.email,
            registerViewObject.password,
            registerViewObject.profileImage)))
        .fold((failure) {
      // left -> failure
      inputState.add(
          ErrorState(StateRendererType.PUPUP_ERROR_STATE, failure.message));
    }, (data) {
      // right -> success (data)
      inputState.add(ContentState());
      //  isLoginSuccessfullyStreamController.add(true);

      isUserLoggedInSuccessfullyStreamController.add(true);
    });
  }

  @override
  void dispose() {
    _firstNameStreamController.close();
    _lastNameStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
    _profileStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();

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
  Sink get inputProfilePicture => _profileStreamController.sink;

  @override
  Sink get inputAllInputsValid => _isAllInputsValidStreamController.sink;

  // ................. OUTPUT ...............

  // first name
  @override
  Stream<bool> get outputIsFirstNameValid => _firstNameStreamController.stream
      .map((firstName) => _isFirstNameValid(firstName));

  @override
  Stream<String?> get outputErrorFirstName => outputIsFirstNameValid.map(
      (isFirstNameValid) => isFirstNameValid ? null : "Invalid first name");

// last name
  @override
  Stream<bool> get outputIsLastNameValid => _lastNameStreamController.stream
      .map((lastName) => _isLastNameValid(lastName));

  @override
  Stream<String?> get outputErrorLastName => outputIsLastNameValid
      .map((isLastNameValid) => isLastNameValid ? null : "Invalid last name");

// email
  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isValidEmail(email));

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : "Invalid email");

// password
  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid
      .map((isPasswordValid) => isPasswordValid ? null : "Invalid password");

// all input valid
  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _validateAllInputs());

  // profile picture
  @override
  Stream<File?> get outputProfilePicture =>
      _profileStreamController.stream.map((profilePicture) => profilePicture);

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

  bool _validateAllInputs() {
    return registerViewObject.email.isNotEmpty &&
        registerViewObject.password.isNotEmpty &&
        registerViewObject.firstName.isNotEmpty &&
        registerViewObject.lastName.isNotEmpty;
  }

  _validate() {
    inputAllInputsValid.add(null);
  }

  @override
  setFirstName(String firstName) {
    inputFirstName.add(firstName);
    if (_isFirstNameValid(firstName)) {
      // update register object with first name
      registerViewObject = registerViewObject.copyWith(firstName: firstName);
    } else {
      // reset user name value in register view object
      registerViewObject = registerViewObject.copyWith(firstName: '');
    }
    _validate();
  }

  @override
  setLastName(String lastName) {
    inputLastName.add(lastName);
    if (_isLastNameValid(lastName)) {
      registerViewObject = registerViewObject.copyWith(lastName: lastName);
    } else {
      registerViewObject = registerViewObject.copyWith(lastName: '');
    }
    _validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isValidEmail(email)) {
      registerViewObject = registerViewObject.copyWith(email: email);
    } else {
      registerViewObject = registerViewObject.copyWith(email: '');
    }
    _validate();
  }

  @override
  setPassword(String pass) {
    inputPassword.add(pass);
    if (_isPasswordValid(pass)) {
      registerViewObject = registerViewObject.copyWith(password: pass);
    } else {
      registerViewObject = registerViewObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setProfilePicture(File file) {
    inputProfilePicture.add(file);
    if (file.path.isNotEmpty) {
      registerViewObject = registerViewObject.copyWith(profileImage: file.path);
    } else {
      registerViewObject = registerViewObject.copyWith(profileImage: '');
    }
    _validate();
  }
}

abstract class RegisterViewModelInput {
  register();

  setFirstName(String firstName);
  setLastName(String lastName);
  setEmail(String email);
  setPassword(String pass);
  setProfilePicture(File file);

  Sink get inputFirstName;
  Sink get inputLastName;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputAllInputsValid;
  Sink get inputProfilePicture;
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
  Stream<bool> get outputIsAllInputsValid;
  Stream<File?> get outputProfilePicture;
}
