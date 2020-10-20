import '../models/entry.dart';

/// [getFirstLetter] abstracts the retrieval of the first letter used for fallback icons
String getFirstLetter(Entry entry) {
  if (entry.name.isNotEmpty) {
    return entry.name[0].toUpperCase();
  } else {
    return entry.username[0].toUpperCase();
  }
}
