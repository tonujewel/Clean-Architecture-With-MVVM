import 'package:clean_architecture_with_mvvm/app/di.dart';
import 'package:clean_architecture_with_mvvm/presentation/register/register_view_model.dart';
import 'package:flutter/material.dart';

import '../common/state_renderer/state_render_impl.dart';
import '../resources/color_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();

  final TextEditingController _firstNameTextEditingController =
      TextEditingController();

  final TextEditingController _lastNameTextEditingController =
      TextEditingController();

  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();

    // first name
    _firstNameTextEditingController.addListener(() {
      _viewModel.setFirstName(_firstNameTextEditingController.text);
    });

    // last name
    _lastNameTextEditingController.addListener(() {
      _viewModel.setLastName(_lastNameTextEditingController.text);
    });

    // email
    _emailTextEditingController.addListener(() {
      _viewModel.setEmail(_emailTextEditingController.text);
    });

    // password
    _passwordTextEditingController.addListener(() {
      _viewModel.setPassword(_passwordTextEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return Center(
            child: snapshot.data?.getScreenWidget(context, _getContectWidget(),
                    () {
                  _viewModel.register();
                }) ??
                _getContectWidget(),
          );
        },
      ),
    );
  }

  Widget _getContectWidget() {
    return Container();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
