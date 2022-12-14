
import 'package:clean_architecture_with_mvvm/app/di.dart';
import 'package:clean_architecture_with_mvvm/presentation/forgot_password/forgot_password_view.dart';
import 'package:clean_architecture_with_mvvm/presentation/login/login_view.dart';
import 'package:clean_architecture_with_mvvm/presentation/main/main_view.dart';
import 'package:clean_architecture_with_mvvm/presentation/on_borading/onboarding_view.dart';
import 'package:clean_architecture_with_mvvm/presentation/register/register_view.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/string_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/splash/splash_view.dart';
import 'package:clean_architecture_with_mvvm/presentation/store_details/store_details_view.dart';
import 'package:flutter/material.dart';

import '../forgot_otp_screen/forgot_otp_screen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onboarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotpassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storedetails";
  static const String forgetOtpScreenRoute = "/forgetotpscreen";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;

 
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.loginRoute:
        initLoginModule(); // init login DI
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        initRegisterModule(); // init register DI
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPasswordRoute:
        initForgotModule(); // init forgot DI
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        initRestaurantDetailsModule();
        return MaterialPageRoute(
            builder: (_) => StoreDetailsView(
                  id: arguments.toString(),
                ));
      case Routes.forgetOtpScreenRoute:
        return MaterialPageRoute(builder: (_) => const ForgetOtpScreen());
      default:
        return undefineRoute();
    }
  }

  static Route<dynamic> undefineRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text(AppString.noRouteFound)),
        body: const Center(
          child: Text(AppString.noRouteFound),
        ),
      ),
    );
  }
}
