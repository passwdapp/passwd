import 'entry.dart';
import 'tag.dart';

/// [Entries] class is used to store the whole DB in memory
/// It stores a list of [Tag] and [Entry] models
/// [Entries] is JSON and MsgPack serializable
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
      entries = <Entry>[];
      json['e'].forEach((v) {
        entries.add(Entry.fromJson(v.cast<String, dynamic>()));
      });
    }
    if (json['t'] != null) {
      tags = <Tag>[];
      json['t'].forEach((v) {
        tags.add(Tag.fromJson(v.cast<String, dynamic>()));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (entries != null) {
      data['e'] = entries.map((v) => v.toJson()).toList();
    }
    if (tags != null) {
      data['t'] = tags.map((v) => v.toJson()).toList();
    }
    data['v'] = version;
    return data;
  }
}
