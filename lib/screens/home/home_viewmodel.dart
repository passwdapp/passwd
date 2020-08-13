import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:passwd/models/entries.dart';
import 'package:passwd/models/entry.dart';
import 'package:passwd/router/router.gr.dart';
import 'package:passwd/services/locator.dart';
import 'package:passwd/services/sync/sync_service.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ChangeNotifier {
  Entries _entries = Entries(entries: []);
  Entries get entries => _entries;

  bool _loading = true;
  bool get loading => _loading;

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  HomeViewModel() {
    loadDb();
  }

  Future loadDb() async {
    Entries test = await locator<SyncService>().readDatabaseLocally();
    print(jsonEncode(test));
    _entries = test;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    loading = false;
  }

  Future toAdd() async {
    loading = true;
    Entry entry =
        await locator<NavigationService>().navigateTo(Routes.addAccountScreen);

    if (entry != null) {
      _entries.entries.add(entry);
      print(jsonEncode(_entries.toJson()));
      await locator<SyncService>().syncronizeDatabaseLocally(entries);
      print("Synced :thinking:");
      await loadDb();
    } else {
      loading = false;
    }
  }
}
