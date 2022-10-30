import 'package:clean_architecture_with_mvvm/app/app_prefs.dart';
import 'package:clean_architecture_with_mvvm/app/di.dart';
import 'package:clean_architecture_with_mvvm/presentation/common/state_renderer/state_render_impl.dart';
import 'package:clean_architecture_with_mvvm/presentation/login/login_view_model.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/asset_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/color_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/route_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/string_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel =
      instance<LoginViewModel>(); // Dependency Injection

  final AppPreferences _appPreferences = instance<AppPreferences>();

  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  void _bind() {
    _viewModel.start();
    _usernameTextController.addListener(
        () => _viewModel.setUserName(_usernameTextController.text));

    _passwordTextController.addListener(
        () => _viewModel.setPassword(_passwordTextController.text));

    _viewModel.isLoginSuccessfullyStreamController.stream
        .listen((isLoginSuccess) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _appPreferences.setIsUserLoggedIn();
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });
    });
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
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContectWidget(),
                  () {
                _viewModel.login();
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
          key: _formKey,
          child: Column(
            children: [
              Image.asset(AssetManager.splashLogoPng),
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
                          hintText: AppString.username.tr(),
                          labelText: AppString.username.tr(),
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppString.usernameError.tr(),
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
                        obscureText: true,
                        controller: _passwordTextController,
                        decoration: InputDecoration(
                          hintText: AppString.password.tr(),
                          labelText: AppString.password.tr(),
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppString.passwordError.tr(),
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
                          child:  Text(AppString.login.tr())),
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
                          AppString.forgotPassword.tr(),
                          style: Theme.of(context).textTheme.subtitle2,
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.registerRoute);
                        },
                        child: Text(
                          AppString.registerText.tr(),
                          style: Theme.of(context).textTheme.subtitle2,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
