import 'package:clean_architecture_with_mvvm/data/mapper/mapper.dart';
import 'package:clean_architecture_with_mvvm/data/network/failure.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/asset_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/color_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/font_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/string_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/style_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
// POP UP
  POPUP_LOADING_STATE,
  PUPUP_ERROR_STATE,
  PUPUP_SUCCESS_STATE,

  // FULL SCREEN
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_EMPTY_STATE, // WHEN RECEIVER NO DATA FROM API
  FULL_SCREEN_ERROR_STATE,
  CONTENT_SCREEN_STATE, // THE UI OF THE SCREEN

}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;

  String message;
  String title;
  Function? retryAction;

  StateRenderer(
      {Key? key,
      required this.stateRendererType,
      Failure? failure,
      String? message,
      String? title,
      required this.retryAction})
      : message = message ?? AppString.loading,
        title = title ?? EMPTY,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopUpDialog(
            context, [_getAnimatedImage(JsonManager.loading)]);
      case StateRendererType.PUPUP_ERROR_STATE:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonManager.error),
          _getMessage(message),
          _getRetryButton(AppString.ok, context),
        ]);
      case StateRendererType.PUPUP_SUCCESS_STATE:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonManager.success),
          _getMessage(message),
          _getRetryButton(AppString.ok, context),
        ]);
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getItemsInColumn(
            [_getAnimatedImage(JsonManager.loading), _getMessage(message)]);
      case StateRendererType.FULL_SCREEN_EMPTY_STATE:
        return _getItemsInColumn(
            [_getAnimatedImage(JsonManager.empty), _getMessage(message)]);
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getItemsInColumn([
          _getAnimatedImage(JsonManager.error),
          _getMessage(message),
          _getRetryButton(AppString.retryAgain, context),
        ]);
      case StateRendererType.CONTENT_SCREEN_STATE:
        return Container();
      default:
        return Container();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> childres) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(AppSize.s14)),
        elevation: AppSize.s1_5,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: ColorManager.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(AppSize.s14),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: AppSize.s12,
                    offset: Offset(AppSize.s0, AppSize.s12))
              ]),
          child: _getDialogContect(context, childres),
        ));
  }

  Widget _getDialogContect(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName), // json image
    );
  }

  Widget _getMessage(String message) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppPadding.p10, left: AppPadding.p10, right: AppPadding.p10),
      child: Text(
        message,
        style: getMediumTextStyle(
            color: ColorManager.black, fontSize: FontSize.s16),
      ),
    );
  }

  Widget _getRetryButton(String buttonText, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: AppSize.s180,
          child: ElevatedButton(
              onPressed: () {
                if (stateRendererType ==
                    StateRendererType.FULL_SCREEN_ERROR_STATE) {
                  retryAction?.call();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(buttonText)),
        ),
      ),
    );
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
