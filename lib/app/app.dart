import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal(); // private name constructor

  static const MyApp instance =
      MyApp._internal(); // single instance - singletone

  factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
