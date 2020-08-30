import 'package:flutter/material.dart';
import 'package:passwd/screens/home/home_viewmodel.dart';
import 'package:passwd/screens/home_passwords/home_passwords_sceeen.dart';
import 'package:passwd/screens/home_settings/home_settings_screen.dart';
import 'package:passwd/screens/home_tags/home_tags_screen.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatelessWidget {
  final List<Widget> items = [
    HomePasswordsScreen(),
    HomeTagsScreen(),
    HomeSettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        body: IndexedStack(
          children: items,
          index: 0,
        ),
      ),
    );
  }
}
