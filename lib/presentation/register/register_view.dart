import 'package:clean_architecture_with_mvvm/app/di.dart';
import 'package:clean_architecture_with_mvvm/presentation/register/register_view_model.dart';
import 'package:flutter/material.dart';

import '../common/state_renderer/state_render_impl.dart';
import '../resources/asset_manager.dart';
import '../resources/color_manager.dart';
import '../resources/route_manager.dart';
import '../resources/string_manager.dart';
import '../resources/values_manager.dart';

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

  final GlobalKey _formKey = GlobalKey<FormState>();

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
    return Container(
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

              // first Name
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorFirstName,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _firstNameTextEditingController,
                        decoration: InputDecoration(
                          hintText: AppString.firstName,
                          labelText: AppString.firstName,
                          errorText: snapshot.data,
                        ),
                      );
                    }),
              ),
              const SizedBox(height: AppPadding.p28),

              // last name
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorLastName,
                    builder: (context, snapshot) {
                      return TextFormField(
                        obscureText: true,
                        controller: _lastNameTextEditingController,
                        decoration: InputDecoration(
                          hintText: AppString.lastName,
                          labelText: AppString.lastName,
                          errorText: snapshot.data,
                        ),
                      );
                    }),
              ),

              // email
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorEmail,
                    builder: (context, snapshot) {
                      return TextFormField(
                        obscureText: true,
                        controller: _emailTextEditingController,
                        decoration: InputDecoration(
                          hintText: AppString.email,
                          labelText: AppString.email,
                          errorText: snapshot.data,
                        ),
                      );
                    }),
              ),

              // password
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorPassword,
                    builder: (context, snapshot) {
                      return TextFormField(
                        obscureText: true,
                        controller: _passwordTextEditingController,
                        decoration: InputDecoration(
                          hintText: AppString.password,
                          labelText: AppString.password,
                          errorText: snapshot.data,
                        ),
                      );
                    }),
              ),

              const SizedBox(height: AppPadding.p28),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputIsAllInputVlid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  _viewModel.register();
                                }
                              : null,
                          child: const Text(AppString.login)),
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
                          AppString.alreadyHaveAccount,
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
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
