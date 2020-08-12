import 'package:passwd/models/entry.dart';

class Entries {
  List<Entry> entries;

  Entries({this.entries});

  Entries.fromJson(Map<String, dynamic> json) {
    if (json['entries'] != null) {
      entries = List<Entry>();
      json['entries'].forEach((v) {
        entries.add(Entry.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.entries != null) {
      data['entries'] = this.entries.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
