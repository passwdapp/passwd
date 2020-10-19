import '../../models/entries.dart';
import '../../models/entry.dart';
import '../../models/tag.dart';

abstract class DatabaseService {
  Future reloadDatabaseFromDisk();
  Future syncAndReloadDatabase();
  Entries get entries;
  Future addEntry(Entry entry);
  Future modifyEntry(Entry old, Entry changed);
  Future removeEntryAt(int index);
  Future addTag(Tag tag);
}
