import '../../models/entries.dart';

abstract class SyncService {
  Future<bool> syncronizeDatabaseLocally(Entries entries);
  Future<Entries> readDatabaseLocally();
}
