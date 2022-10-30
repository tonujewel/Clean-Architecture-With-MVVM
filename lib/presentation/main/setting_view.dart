import 'dart:developer';

import 'package:clean_architecture_with_mvvm/app/app_prefs.dart';
import 'package:clean_architecture_with_mvvm/app/di.dart';
import 'package:clean_architecture_with_mvvm/data/data_sources/local_data_source.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/asset_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/route_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text(
            AppString.changeLanguage,
            style: Theme.of(context).textTheme.headline4,
          ),
          leading: SvgPicture.asset(AssetManager.changeLanguageIcon),
          trailing: SvgPicture.asset(AssetManager.settingRightArrowIcon),
          onTap: () {
            _changeLanguage();
          },
        ),
        ListTile(
          title: Text(
            AppString.contactUs,
            style: Theme.of(context).textTheme.headline4,
          ),
          leading: SvgPicture.asset(AssetManager.contactUsIcon),
          trailing: SvgPicture.asset(AssetManager.settingRightArrowIcon),
          onTap: () {
            _contactUs();
          },
        ),
        ListTile(
          title: Text(
            AppString.inviteYourFriend,
            style: Theme.of(context).textTheme.headline4,
          ),
          leading: SvgPicture.asset(AssetManager.inviteFriendIcon),
          trailing: SvgPicture.asset(AssetManager.settingRightArrowIcon),
          onTap: () {
            _inviteFriend();
          },
        ),
        ListTile(
          title: Text(
            AppString.logout,
            style: Theme.of(context).textTheme.headline4,
          ),
          leading: SvgPicture.asset(AssetManager.logoutIcon),
          trailing: SvgPicture.asset(AssetManager.settingRightArrowIcon),
          onTap: () {
            _logout();
          },
        ),
      ],
    );
  }

  void _changeLanguage() {
    //
  }

  void _contactUs() {
    //
  }

  void _inviteFriend() {
    //
  }

  void _logout() {
    _localDataSource.clearCache();
    _appPreferences.logout();
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
