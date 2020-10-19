import 'package:async_redux/async_redux.dart';

import '../../models/entry.dart';
import '../../services/database/database_service.dart';
import '../../services/locator.dart';
import '../appstate.dart';

class SyncIndicatorAction extends ReduxAction<AppState> {
  final bool isSyncing;
  SyncIndicatorAction({this.isSyncing}) : assert(isSyncing != null);

  @override
  AppState reduce() {
    return state.copyWith(
      isSyncing: false,
    );
  }
}

class ReloadAction extends ReduxAction<AppState> {
  final bool reloadFromDisk;
  ReloadAction({this.reloadFromDisk = false});

  @override
  void before() => dispatch(SyncIndicatorAction(isSyncing: true));

  @override
  Future<AppState> reduce() async {
    if (reloadFromDisk) {
      await locator<DatabaseService>().reloadDatabaseFromDisk();
    }
    final entries = locator<DatabaseService>().entries;

    return state.copyWith(
      entries: entries,
    );
  }

  @override
  void after() => dispatch(
        SyncIndicatorAction(isSyncing: false),
      );
}

class AddEntryAction extends ReduxAction<AppState> {
  final Entry entry;
  AddEntryAction(this.entry);

  @override
  void before() => dispatch(SyncIndicatorAction(isSyncing: true));

  @override
  Future<AppState> reduce() async {
    await locator<DatabaseService>().addEntry(entry);
    return null;
  }

  @override
  void after() => dispatch(ReloadAction());
}

class ModifyEntryAction extends ReduxAction<AppState> {
  final Entry oldEntry;
  final Entry newEntry;

  ModifyEntryAction(this.oldEntry, this.newEntry);

  @override
  void before() => dispatch(SyncIndicatorAction(isSyncing: true));

  @override
  Future<AppState> reduce() async {
    await locator<DatabaseService>().modifyEntry(oldEntry, newEntry);
    return null;
  }

  @override
  void after() => dispatch(ReloadAction());
}

class RemoveEntryAction extends ReduxAction<AppState> {
  final int itemId;
  RemoveEntryAction(this.itemId);

  @override
  void before() => dispatch(SyncIndicatorAction(isSyncing: true));

  @override
  Future<AppState> reduce() async {
    await locator<DatabaseService>().removeEntryAt(itemId);
    return null;
  }

  @override
  void after() => dispatch(ReloadAction());
}
