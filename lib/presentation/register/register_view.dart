import 'dart:io';
import 'package:clean_architecture_with_mvvm/app/app_prefs.dart';
import 'package:clean_architecture_with_mvvm/app/di.dart';
import 'package:clean_architecture_with_mvvm/presentation/register/register_view_model.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/route_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../common/state_renderer/state_render_impl.dart';
import '../resources/asset_manager.dart';
import '../resources/color_manager.dart';
import '../resources/string_manager.dart';
import '../resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker picker = instance<ImagePicker>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

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

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
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

    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isSuccessLoggedIn) {
      // navigate to main screen
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _appPreferences.setIsUserLoggedIn();
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });
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
              Image.asset(AssetManager.splashLogoPng),
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
                          hintText: AppString.firstName.tr(),
                          labelText: AppString.firstName.tr(),
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
                        controller: _lastNameTextEditingController,
                        decoration: InputDecoration(
                          hintText: AppString.lastName.tr(),
                          labelText: AppString.lastName.tr(),
                          errorText: snapshot.data,
                        ),
                      );
                    }),
              ),
              const SizedBox(height: AppPadding.p28),
              // email
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorEmail,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _emailTextEditingController,
                        decoration: InputDecoration(
                          hintText: AppString.email.tr(),
                          labelText: AppString.email.tr(),
                          errorText: snapshot.data,
                        ),
                      );
                    }),
              ),
              const SizedBox(height: AppPadding.p28),
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
                          hintText: AppString.password.tr(),
                          labelText: AppString.password.tr(),
                          errorText: snapshot.data,
                        ),
                      );
                    }),
              ),
              const SizedBox(height: AppPadding.p28),
              // profile image
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s4),
                    border: Border.all(color: ColorManager.black),
                  ),
                  child: InkWell(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: _getMedialWidget(),
                  ),
                ),
              ),

              // register button
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
                                    _viewModel.register();
                                  }
                                : null,
                            child: Text(AppString.registration.tr())),
                      );
                    },
                  )),

              // aleady have account
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                    top: AppPadding.p8),
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppString.alreadyHaveAccount.tr(),
                      style: Theme.of(context).textTheme.subtitle2,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera),
                title: Text(AppString.photoFromGallery.tr()),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera_alt_rounded),
                title: Text(AppString.photoFromCamera.tr()),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
        });
  }

  _imageFromGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  _imageFromCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);

    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  Widget _getMedialWidget() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Flexible(
              child: Text(
            AppString.profilePicture.tr(),
            style: const TextStyle(fontSize: 12),
          )),
          StreamBuilder<File?>(
              stream: _viewModel.outputProfilePicture,
              builder: (context, snapshot) {
                return _imagePicByUser(snapshot.data);
              }),
          Flexible(child: SvgPicture.asset(AssetManager.cameraIcon))
        ],
      ),
    );
  }

  Widget _imagePicByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image, height: 30);
    } else {
      return const SizedBox();
    }
  }
}
