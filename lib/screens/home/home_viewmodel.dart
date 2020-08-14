import 'package:flutter/foundation.dart';
import 'package:passwd/models/entries.dart';
import 'package:passwd/models/entry.dart';
import 'package:passwd/router/router.gr.dart';
import 'package:passwd/services/favicon/favicon_service.dart';
import 'package:passwd/services/locator.dart';
import 'package:passwd/services/sync/sync_service.dart';
import 'package:passwd/utils/validate.dart';
import 'package:passwd/validators/url_validator.dart';
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
    await Future.delayed(Duration(milliseconds: 500));
    loading = false;
  }

  Future syncDB() async {
    await locator<SyncService>().syncronizeDatabaseLocally(entries);
    await reloadDB();
  }

  Future removeEntry(int itemId) async {
    loading = true;
    notifyListeners();
    _entries.entries.removeAt(itemId);
    notifyListeners();
    await syncDB();
  }

  Future toAdd() async {
    loading = true;
    Entry entry =
        await locator<NavigationService>().navigateTo(Routes.addAccountScreen);

    if (entry != null) {
      int index = _entries.entries.length;
      _entries.entries.add(entry);
      notifyListeners();
      await syncDB();

      if (entry.name != null) {
        if (validate<bool>(URLValidator(), entry.name, true, false)) {
          String favicon = await locator<FaviconService>().getBestFavicon(
            entry.name.startsWith("http")
                ? Uri.parse(entry.name).host
                : entry.name.split("/")[0],
          );

          if (favicon.isNotEmpty) {
            _entries.entries.elementAt(index).favicon = favicon;
            await syncDB();
          }
        }
      }
    } else {
      loading = false;
    }
  }

  void showDetails(Entry entry) {
    locator<NavigationService>().navigateTo(
      Routes.accountDetailsScreen,
      arguments: AccountDetailsScreenArguments(
        entry: entry,
      ),
    );
  }
}
