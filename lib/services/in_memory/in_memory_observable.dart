import 'package:injectable/injectable.dart';
import 'package:passwd/models/entry.dart';
import 'package:passwd/models/entries.dart';
import 'package:passwd/services/in_memory/in_memory_service.dart';
import 'package:passwd/services/locator.dart';
import 'package:passwd/services/sync/sync_service.dart';

@LazySingleton(as: InMemoryService)
class InMemoryObservable implements InMemoryService {
  Entries _entries = Entries(entries: []);
  SyncService syncService = locator<SyncService>();

  InMemoryObservable() {
    reloadDatabaseFromDisk();
  }

  Future reloadDatabaseFromDisk() async {
    _entries = await syncService.readDatabaseLocally();
  }

  @override
  Entries get entries => _entries;

  @override
  Future addEntry(Entry entry) async {
    entries.entries.add(entry);
    syncService.syncronizeDatabaseLocally(entries);
    reloadDatabaseFromDisk();
  }

  @override
  Future removeAt(int index) async {
    entries.entries.removeAt(index);
    syncService.syncronizeDatabaseLocally(entries);
    reloadDatabaseFromDisk();
  }
}
