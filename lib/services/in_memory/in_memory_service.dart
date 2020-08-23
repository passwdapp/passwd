import 'package:passwd/models/entries.dart';
import 'package:passwd/models/entry.dart';

abstract class InMemoryService {
  Entries get entries;
  Future addEntry(Entry entry);
  Future modifyEntry(Entry old, Entry changed);
  Future removeEntryAt(int index);
}
