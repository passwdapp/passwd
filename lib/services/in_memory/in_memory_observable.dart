import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:passwd/models/entry.dart';
import 'package:passwd/models/entries.dart';
import 'package:passwd/services/in_memory/in_memory_service.dart';
import 'package:passwd/services/locator.dart';
import 'package:passwd/services/sync/sync_service.dart';
import 'package:stacked/stacked.dart';

@LazySingleton(as: InMemoryService)
class InMemoryObservable with ReactiveServiceMixin implements InMemoryService {
  RxValue _entries = RxValue<Entries>(
    initial: Entries(entries: []),
  );
  SyncService syncService = locator<SyncService>();

  InMemoryObservable() {
    reloadDatabaseFromDisk();
  }

  Future reloadDatabaseFromDisk() async {
    _entries.value = await syncService.readDatabaseLocally();
  }

  @override
  Entries get entries => _entries.value;

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
