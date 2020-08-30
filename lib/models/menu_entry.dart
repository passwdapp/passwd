import 'package:flutter/widgets.dart';

class MenuEntry {
  final String localizationTag;
  final IconData icon;

  const MenuEntry({this.icon, this.localizationTag})
      : assert(localizationTag != null),
        assert(icon != null);
}
