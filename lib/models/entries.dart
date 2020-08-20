import 'package:passwd/models/entry.dart';

class Entries {
  List<Entry> entries;
  int version;

  Entries({
    this.entries,
    this.version,
  });

  Entries.fromJson(Map<String, dynamic> json) {
    version = json['v'];
    if (json['e'] != null) {
      entries = List<Entry>();
      json['e'].forEach((v) {
        entries.add(Entry.fromJson(v.cast<String, dynamic>()));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.entries != null) {
      data['e'] = this.entries.map((v) => v.toJson()).toList();
    }
    data['v'] = this.version;
    return data;
  }
}
