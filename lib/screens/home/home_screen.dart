import 'package:async_redux/async_redux.dart' hide ViewModelBuilder;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../constants/colors.dart';
import '../../constants/menu_entries.dart';
import '../../redux/actions/entries.dart';
import '../home_passwords/home_passwords_sceeen.dart';
import '../home_settings/home_settings_screen.dart';
import '../home_tags/home_tags_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> items = [
    HomePasswordsScreen(),
    HomeTagsScreen(),
    HomeSettingsScreen(),
  ];

  var currentItem = 0;
  void setCurrentItem(int item) {
    if (currentItem != item) {
      setState(() {
        currentItem = item;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<DispatchFuture>(
      context,
      listen: false,
    )(ReloadAction(reloadFromDisk: true));

    return ScreenTypeLayout(
      mobile: Scaffold(
        bottomNavigationBar: Builder(
          builder: (context) {
            return BottomNavigationBar(
              onTap: (i) {
                setCurrentItem(i);
              },
              currentIndex: currentItem,
              items: navMenuEntries
                  .map(
                    (e) => BottomNavigationBarItem(
                      icon: Icon(e.icon),
                      label: e.localizationTag,
                    ),
                  )
                  .toList(),
            );
          },
        ),
        body: stack,
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
                    setCurrentItem(i);
                  },
                  hoverColor: primaryColor.withOpacity(0.08),
                  selected: i == currentItem,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 4,
                ),
                child: stack,
              ),
            ),
          ],
        ),
      ),
      tablet: Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: currentItem,
              onDestinationSelected: (i) {
                setCurrentItem(i);
              },
              labelType: NavigationRailLabelType.all,
              destinations: navMenuEntries
                  .map(
                    (e) => NavigationRailDestination(
                      icon: Icon(e.icon),
                      label: Text(e.localizationTag),
                    ),
                  )
                  .toList(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 4,
                ),
                child: stack,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get stack => IndexedStack(
        children: items,
        index: currentItem,
      );
}
