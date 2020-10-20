/// [Tag] stores a tag which is persisted to the DB
/// [id] is a 24-length randomly generated string
/// [color] here is the index of the [iconColors] list
/// [name] represents the user-entered name
/// [Tag] is JSON and MsgPack serializable
class Tag {
  String id;
  String name;
  int color;

  Tag({this.id, this.name, this.color});

  Tag.fromJson(Map<String, dynamic> json) {
    id = json['i'];
    name = json['n'];
    color = json['c'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['i'] = id;
    data['n'] = name;
    data['c'] = color;
    return data;
  }
}
