import 'package:clean_architecture_with_mvvm/data/network/failure.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';

enum StateRendererType {
// POP UP
  POPUP_LOADING_STATE,
  PUPUP_ERROR_STATE,

  // FULL SCREEN
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_EMPTY_STATE, // WHEN RECEIVER NO DATA FROM API
  FULL_SCREEN_ERROR_STATE,
  CONTENT_SCREEN_STATE, // THE UI OF THE SCREEN

}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  Failure failure;
  String message;
  String title;
  Function retryAction;

  StateRenderer(
      {Key? key,
      required this.stateRendererType,
      Failure? failure,
      String? message,
      String? title,
      required this.retryAction})
      : message = message ?? AppString.loading,
        title = title ?? "",
        failure = failure ?? DefaultFailure(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
