import 'package:clean_architecture_with_mvvm/presentation/login/login_view_model.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/asset_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/color_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/string_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel =
      LoginViewModel(null); // TODO: PASS HERE LOGIN USECASE

  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  void _bind() {
    _viewModel.start();
    _usernameTextController.addListener(
        () => _viewModel.setUserName(_usernameTextController.text));

    _passwordTextController
        .addListener(() => _viewModel.setPasswrd(_passwordTextController.text));
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
    return Container();
  }

  Widget _getContectWidget() {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: AppPadding.p100,
        ),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SvgPicture.asset(AssetManager.splashLogo),
                const SizedBox(height: AppPadding.p28),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsUsernameValid,
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
                    //     stream: ,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                          onPressed: () {}, child: Text(AppString.login));
                    },
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
