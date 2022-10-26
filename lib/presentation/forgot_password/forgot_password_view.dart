import 'package:clean_architecture_with_mvvm/app/di.dart';
import 'package:clean_architecture_with_mvvm/presentation/forgot_password/forgot_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../common/state_renderer/state_render_impl.dart';
import '../resources/asset_manager.dart';
import '../resources/color_manager.dart';
import '../resources/route_manager.dart';
import '../resources/string_manager.dart';
import '../resources/values_manager.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final ForgotPasswordViewModel _viewModel =
      instance<ForgotPasswordViewModel>();

  final TextEditingController _emailTextController = TextEditingController();

  _bind() {
    _viewModel.start();
    // checking email
    _emailTextController
        .addListener(() => _viewModel.setEmai(_emailTextController.text));

    // is api call success
    _viewModel.isForgotSuccessfullyStreamController.stream
        .listen((isForgetSuccess) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.of(context).pushNamed(Routes.forgetOtpScreenRoute);
      });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContectWidget(),
                  () {
                _viewModel.forgotPassword();
              }) ??
              _getContectWidget();
        },
      ),
    );
  }

  Widget _getContectWidget() {
    return Container(
      padding: const EdgeInsets.only(
        top: AppPadding.p100,
      ),
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              Image.asset(AssetManager.splashLogo),
              const SizedBox(height: AppPadding.p28),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsEmailValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailTextController,
                        decoration: InputDecoration(
                          hintText: AppString.email,
                          labelText: AppString.email,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppString.emailError,
                        ),
                      );
                    }),
              ),
              const SizedBox(height: AppPadding.p28),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputIsEmailValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  _viewModel.forgotPassword();
                                }
                              : null,
                          child: const Text(AppString.sendVarificationCode)),
                    );
                  },
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: AppPadding.p28,
              //       right: AppPadding.p28,
              //       top: AppPadding.p8),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       TextButton(
              //           onPressed: () {
              //             Navigator.pushReplacementNamed(
              //                 context, Routes.forgotPasswordRoute);
              //           },
              //           child: Text(
              //             AppString.forgotPassword,
              //             style: Theme.of(context).textTheme.subtitle2,
              //           )),
              //       TextButton(
              //           onPressed: () {
              //             Navigator.pushReplacementNamed(
              //                 context, Routes.registerRoute);
              //           },
              //           child: Text(
              //             AppString.registerText,
              //             style: Theme.of(context).textTheme.subtitle2,
              //           )),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
