import 'entry.dart';
import 'tag.dart';

class Entries {
  List<Entry> entries;
  List<Tag> tags;
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
    if (json['t'] != null) {
      tags = List<Tag>();
      json['t'].forEach((v) {
        tags.add(Tag.fromJson(v.cast<String, dynamic>()));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.entries != null) {
      data['e'] = this.entries.map((v) => v.toJson()).toList();
    }
    if (this.tags != null) {
      data['t'] = this.tags.map((v) => v.toJson()).toList();
    }
    data['v'] = this.version;
    return data;
  }
}
