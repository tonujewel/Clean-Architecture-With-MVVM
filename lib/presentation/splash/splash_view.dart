import 'dart:async';
import 'package:clean_architecture_with_mvvm/presentation/resources/color_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/route_manager.dart';
import 'package:flutter/material.dart';
import '../resources/asset_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 3), _goToNextPage);
  }

  _goToNextPage() {
    Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primar,
      body: const Center(
        child: Image(
          image: AssetImage(AssetManager.splashLogo),
        ),
      ),
    );
  }
}
