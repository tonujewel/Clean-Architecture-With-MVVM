import 'dart:math' as math;
import 'package:clean_architecture_with_mvvm/app/app_prefs.dart';
import 'package:clean_architecture_with_mvvm/app/di.dart';
import 'package:clean_architecture_with_mvvm/data/data_sources/local_data_source.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/asset_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/language_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/route_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/string_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
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
            AppString.changeLanguage.tr(),
            style: Theme.of(context).textTheme.headline4,
          ),
          leading: SvgPicture.asset(AssetManager.changeLanguageIcon),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
            child: SvgPicture.asset(AssetManager.settingRightArrowIcon),
          ),
          onTap: () {
            _changeLanguage();
          },
        ),
        ListTile(
          title: Text(
            AppString.contactUs.tr(),
            style: Theme.of(context).textTheme.headline4,
          ),
          leading: SvgPicture.asset(AssetManager.contactUsIcon),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
            child: SvgPicture.asset(AssetManager.settingRightArrowIcon),
          ),
          onTap: () {
            _contactUs();
          },
        ),
        ListTile(
          title: Text(
            AppString.inviteYourFriend.tr(),
            style: Theme.of(context).textTheme.headline4,
          ),
          leading: SvgPicture.asset(AssetManager.inviteFriendIcon),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
            child: SvgPicture.asset(AssetManager.settingRightArrowIcon),
          ),
          onTap: () {
            _inviteFriend();
          },
        ),
        ListTile(
          title: Text(
            AppString.logout.tr(),
            style: Theme.of(context).textTheme.headline4,
          ),
          leading: SvgPicture.asset(AssetManager.logoutIcon),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
            child: SvgPicture.asset(AssetManager.settingRightArrowIcon),
          ),
          onTap: () {
            _logout();
          },
        ),
      ],
    );
  }

  bool isRtl() {
    return context.locale == ARABIK_LOCALE; // app is in arabic language
  }

  void _changeLanguage() {
    _appPreferences.setLanguageChanges();
    Phoenix.rebirth(context);
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
