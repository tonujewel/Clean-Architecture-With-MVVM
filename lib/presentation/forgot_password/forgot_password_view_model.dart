import 'dart:async';
import 'package:clean_architecture_with_mvvm/app/extensions.dart';
import 'package:clean_architecture_with_mvvm/domain/use_case/forgot_user_case.dart';
import 'package:clean_architecture_with_mvvm/presentation/base_view_model/base_view_model.dart';
import 'package:clean_architecture_with_mvvm/presentation/common/freezed_data_classes.dart';
import 'package:clean_architecture_with_mvvm/presentation/common/state_renderer/state_renderer.dart';

import '../common/state_renderer/state_render_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();

  var forgotObject = ForgotObject("");
  final ForgotUseCase _useCase;
  ForgotPasswordViewModel(this._useCase);

   StreamController isForgotSuccessfullyStreamController =
      StreamController<bool>();

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _emailStreamController.close();
    isForgotSuccessfullyStreamController.close();
  }

  //  PRIVATE FUNCTION
  @override
  forgotPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _useCase.execute(ForgotUseCaseInput(forgotObject.email))).fold(
        (failed) {
      inputState
          .add(ErrorState(StateRendererType.PUPUP_ERROR_STATE, failed.message));
    }, (data) {
      inputState.add(ContentState());
      isForgotSuccessfullyStreamController.add(true);
    });
  }

  // INPUT
  @override
  Sink get inputEmail => _emailStreamController.sink;

  //.................. OUTPUT..................
  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  setEmai(String email) {
    inputEmail.add(email);
    forgotObject = forgotObject.copyWith(email: email);
  }

  _isEmailValid(String email) {
    return email.isValidEmail();
  }
}

abstract class ForgotPasswordViewModelInputs {
  // private function
  forgotPassword();
  setEmai(String email);

  // sink for stream
  Sink get inputEmail;
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<bool> get outputIsEmailValid;
}
