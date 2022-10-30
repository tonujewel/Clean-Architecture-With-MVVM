import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../resources/string_manager.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          AppString.search.tr(),
        ),
      ),
    );
  }
}
