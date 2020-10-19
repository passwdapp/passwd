import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../constants/colors.dart';
import '../../constants/menu_entries.dart';
import '../home_passwords/home_passwords_sceeen.dart';
import '../home_settings/home_settings_screen.dart';
import '../home_tags/home_tags_screen.dart';
import 'home_viewmodel.dart';

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
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            onTap: (i) {
              if (i != model.currentItem) {
                model.currentItem = i;
              }
            },
            currentIndex: model.currentItem,
            items: navMenuEntries
                .map(
                  (e) => BottomNavigationBarItem(
                    icon: Icon(e.icon),
                    label: e.localizationTag,
                  ),
                )
                .toList(),
          ),
          body: getStack(
            model.currentItem,
          ),
        ),
        desktop: Scaffold(
          body: Row(
            children: [
              Container(
                width: 272,
                color: Colors.white.withOpacity(0.025),
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 12,
                ),
                child: ListView.builder(
                  itemCount: navMenuEntries.length,
                  itemBuilder: (context, i) => ListTile(
                    leading: Icon(navMenuEntries[i].icon),
                    title: Text(
                      navMenuEntries[i].localizationTag,
                    ),
                    onTap: () {
                      if (i != model.currentItem) {
                        model.currentItem = i;
                      }
                    },
                    hoverColor: primaryColor.withOpacity(0.08),
                    selected: i == model.currentItem,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 4,
                  ),
                  child: getStack(
                    model.currentItem,
                  ),
                ),
              ),
            ],
          ),
        ),
        tablet: getStack(
          model.currentItem,
        ),
      ),
    );
  }

  Widget getStack(int i) {
    return IndexedStack(
      children: items,
      index: i,
    );
  }
}
