import '../models/entry.dart';

String getFirstLetter(Entry entry) {
  if (entry.name.isNotEmpty) {
    return entry.name[0].toUpperCase();
  } else {
    return entry.username[0].toUpperCase();
  }
}
