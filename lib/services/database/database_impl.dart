import 'package:injectable/injectable.dart';

import '../../models/entries.dart';
import '../../models/entry.dart';
import '../../models/tag.dart';
import '../locator.dart';
import '../sync/sync_service.dart';
import 'database_service.dart';

/// [DatabaseImpl] implements the database API exposed by the [DatabaseService]
/// It consumes [SyncService] to provide an abstraction over the raw sync API
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

    if (index != -1) {
      _entries.entries[index] = changed;
      await syncAndReloadDatabase();
    }
  }

  @override
  Future addTag(Tag tag) async {
    if (_entries.tags == null) {
      _entries.tags = [];
    }

    _entries.tags.add(tag);
    await syncAndReloadDatabase();
  }
}
