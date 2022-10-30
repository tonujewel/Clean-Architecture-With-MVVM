import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../resources/string_manager.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          AppString.notification.tr(),
        ),
      ),
    );
  }
}
