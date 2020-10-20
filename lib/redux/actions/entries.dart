import 'package:async_redux/async_redux.dart';

import '../../models/entry.dart';
import '../../services/database/database_service.dart';
import '../../services/locator.dart';
import '../appstate.dart';
import 'favicon.dart';

/// [SyncIndicatorAction] updates the state of the sync indicator
/// It accepts a boolean as its input
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

/// [ReloadAction] is used to reload the DB from the [DatabaseService], and optionally request a reload from disk
/// Reload from disk is usually only dispatched on app's cold startup where the data needs to be accesed from the disk
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
  void after() => dispatch(SyncIndicatorAction(isSyncing: false));
}

/// [AddEntryAction] adds an entry to the database
/// It uses the [DatabaseService] to push an entry to the DB
/// It accepts an [Entry] as its input
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
  void after() {
    dispatch(ReloadAction());
    dispatchFuture(AddFaviconAction(entry));
  }
}

/// [ModifyEntryAction] modifies an existing entry using the [DatabaseService]
/// It accepts 2 [Entry] (the old one, and the updated one)
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

/// [RemoveEntryAction] removes an entry from the DB using the [DatabaseService]
/// It accepts an itemId (not [Entry.id])
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
