import 'package:clean_architecture_with_mvvm/app/di.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
    supportedLocales: const [ENGLISH_LOCALE, ARABIK_LOCALE],
    path: ASSET_PATH_LOCALE,
    child: Phoenix(child: MyApp()),
  ));
}
