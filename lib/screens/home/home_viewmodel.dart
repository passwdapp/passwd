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
    reloadDB();
  }

  Future reloadDB() async {
    Entries test = await locator<SyncService>().readDatabaseLocally();
    _entries = test;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 1000));
    loading = false;
  }

  Future syncDB() async {
    await locator<SyncService>().syncronizeDatabaseLocally(entries);
  }

  Future removeEntry(int itemId) async {
    loading = true;
    _entries.entries.removeAt(itemId);
    notifyListeners();
    await syncDB();
    await reloadDB();
  }

  Future toAdd() async {
    loading = true;
    Entry entry =
        await locator<NavigationService>().navigateTo(Routes.addAccountScreen);

    if (entry != null) {
      _entries.entries.add(entry);
      notifyListeners();
      await syncDB();
      await reloadDB();
    } else {
      loading = false;
    }
  }
}
