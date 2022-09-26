import 'package:clean_architecture_with_mvvm/app/di.dart';
import 'package:clean_architecture_with_mvvm/presentation/login/login_view_model.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/asset_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/color_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/route_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/string_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel =
      instance<LoginViewModel>(); // Dependency Injection

  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  void _bind() {
    _viewModel.start();
    _usernameTextController.addListener(
        () => _viewModel.setUserName(_usernameTextController.text));

    _passwordTextController.addListener(
        () => _viewModel.setPassword(_passwordTextController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getContectWidget();
  }

  Widget _getContectWidget() {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Container(
        padding: const EdgeInsets.only(
          top: AppPadding.p100,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(AssetManager.splashLogo),
                const SizedBox(height: AppPadding.p28),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsUserNameValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _usernameTextController,
                          decoration: InputDecoration(
                            hintText: AppString.username,
                            labelText: AppString.username,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppString.usernameError,
                          ),
                        );
                      }),
                ),
                const SizedBox(height: AppPadding.p28),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsPasswordValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordTextController,
                          decoration: InputDecoration(
                            hintText: AppString.password,
                            labelText: AppString.password,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppString.passwordError,
                          ),
                        );
                      }),
                ),
                const SizedBox(height: AppPadding.p28),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsAllInputsValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    _viewModel.login();
                                  }
                                : null,
                            child: Text(AppString.login)),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28,
                      right: AppPadding.p28,
                      top: AppPadding.p8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.forgotPasswordRoute);
                          },
                          child: Text(
                            AppString.forgotPassword,
                            style: Theme.of(context).textTheme.subtitle2,
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.registerRoute);
                          },
                          child: Text(
                            AppString.registerText,
                            style: Theme.of(context).textTheme.subtitle2,
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
