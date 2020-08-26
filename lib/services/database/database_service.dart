import 'package:passwd/models/entries.dart';
import 'package:passwd/models/entry.dart';
import 'package:passwd/models/tag.dart';

abstract class DatabaseService {
  Future reloadDatabaseFromDisk();
  Future syncAndReloadDatabase();
  Entries get entries;
  Future addEntry(Entry entry);
  Future modifyEntry(Entry old, Entry changed);
  Future removeEntryAt(int index);
  Future addTag(Tag tag);
}
