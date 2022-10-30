import 'package:clean_architecture_with_mvvm/presentation/main/home/home_view.dart';
import 'package:clean_architecture_with_mvvm/presentation/main/notification_view.dart';
import 'package:clean_architecture_with_mvvm/presentation/main/search_view.dart';
import 'package:clean_architecture_with_mvvm/presentation/main/setting_view.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/color_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/string_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomeView(),
    const SearchView(),
    const NotificationView(),
    const SettingsView(),
  ];

  List<String> titleList = [
    AppString.home.tr(),
    AppString.search.tr(),
    AppString.notification.tr(),
    AppString.settings.tr(),
  ];

  var _title = AppString.home.tr();
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorManager.black,
              spreadRadius: AppSize.s1_5,
            )
          ],
        ),
        child: BottomNavigationBar(
            selectedItemColor: ColorManager.primary,
            unselectedItemColor: ColorManager.grey,
            currentIndex: _currentIndex,
            onTap: onTap,
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home), label: titleList[0]),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.search), label: titleList[1]),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.notifications), label: titleList[2]),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.settings), label: titleList[3]),
            ]),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titleList[index];
    });
  }
}
