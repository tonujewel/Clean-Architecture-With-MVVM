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
      return const Scaffold(
      body: Center(
        child: Text(
          AppString.settings,
        ),
      ),
    );
  }
}