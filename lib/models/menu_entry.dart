import 'package:flutter/widgets.dart';

/// [MenuEntry] is used to create a navigation menu item
class MenuEntry {
  final String localizationTag;
  final IconData icon;

  const MenuEntry({this.icon, this.localizationTag})
      : assert(localizationTag != null),
        assert(icon != null);
}
