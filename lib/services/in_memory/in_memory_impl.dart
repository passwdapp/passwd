import 'package:injectable/injectable.dart';
import 'package:passwd/models/entry.dart';
import 'package:passwd/models/entries.dart';
import 'package:passwd/services/in_memory/in_memory_service.dart';
import 'package:passwd/services/locator.dart';
import 'package:passwd/services/sync/sync_service.dart';

@LazySingleton(as: InMemoryService)
class InMemoryImpl implements InMemoryService {
  Entries _entries = Entries(entries: []);
  SyncService syncService = locator<SyncService>();

  Future reloadDatabaseFromDisk() async {
    _entries = await syncService.readDatabaseLocally();
  }

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
    int oldIndex = _entries.entries.indexOf(old);
    _entries.entries[oldIndex] = changed;
    await syncAndReloadDatabase();
  }
}
