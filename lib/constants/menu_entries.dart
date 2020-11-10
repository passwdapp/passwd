import 'package:flutter_icons/flutter_icons.dart';

import '../models/menu_entry.dart';

@deprecated
final navMenuEntries = <MenuEntry>[
  MenuEntry(
    icon: Feather.lock,
    localizationTag: 'nav_passwords',
  ),
  MenuEntry(
    icon: Feather.bookmark,
    localizationTag: 'nav_tags',
  ),
  MenuEntry(
    icon: Feather.settings,
    localizationTag: 'nav_settings',
  ),
];
