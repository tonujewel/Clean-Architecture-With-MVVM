import 'package:clean_architecture_with_mvvm/app/app_prefs.dart';
import 'package:clean_architecture_with_mvvm/app/di.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../presentation/resources/route_manager.dart';
import '../presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal(); // private name constructor

  static const MyApp instance =
      MyApp._internal(); // single instance - singletone

  factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) => {context.setLocale(local)});

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
