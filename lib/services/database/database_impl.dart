import 'package:injectable/injectable.dart';
import 'package:passwd/models/entry.dart';
import 'package:passwd/models/entries.dart';
import 'package:passwd/services/database/database_service.dart';
import 'package:passwd/services/locator.dart';
import 'package:passwd/services/sync/sync_service.dart';

@LazySingleton(as: DatabaseService)
class DatabaseImpl implements DatabaseService {
  Entries _entries = Entries(entries: []);
  SyncService syncService = locator<SyncService>();

  @override
  Future reloadDatabaseFromDisk() async {
    _entries = await syncService.readDatabaseLocally();
  }

  @override
  Future syncAndReloadDatabase() async {
    await syncService.syncronizeDatabaseLocally(_entries);
    await reloadDatabaseFromDisk();
  }

  @override
  Entries get entries => _entries;

  @override
  Future addEntry(Entry entry) async {
    _entries.entries.add(entry);
    await syncAndReloadDatabase();
  }

  @override
  Future removeEntryAt(int index) async {
    _entries.entries.removeAt(index);
    await syncAndReloadDatabase();
  }

  @override
  Future modifyEntry(Entry old, Entry changed) async {
    int index = _entries.entries.indexWhere(
      (element) => element.id == old.id,
    );

    if (index != null) {
      print(index);
      _entries.entries[index] = changed;
      await syncAndReloadDatabase();
    }
  }
}
