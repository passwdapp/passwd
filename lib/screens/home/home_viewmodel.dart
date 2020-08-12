import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:passwd/models/entries.dart';
import 'package:passwd/models/entry.dart';
import 'package:passwd/router/router.gr.dart';
import 'package:passwd/services/locator.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ChangeNotifier {
  Entries _entries = Entries(entries: []);
  Entries get entries => _entries;

  Future toAdd() async {
    Entry entry =
        await locator<NavigationService>().navigateTo(Routes.addAccountScreen);

    if (entry != null) {
      _entries.entries.add(entry);
      print(jsonEncode(entry.toJson()));
    }
  }
}
