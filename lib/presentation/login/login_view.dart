import 'package:clean_architecture_with_mvvm/presentation/login/login_view_model.dart';
import 'package:flutter/material.dart';

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
}
