import 'package:clean_architecture_with_mvvm/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';
class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          AppString.settings,
        ),
      ),
    );
  }
}
