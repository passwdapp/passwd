import 'otp.dart';

/// [Entry] contains the single DB entry for an account
/// [colorId] is generated while saving, and used to create a fallback icon when the [favicon] is unavailable
/// [name] stores the account name
/// [username] stores the username, while [password] stores the password
/// [note] stores the note
/// [favicon] stores the favicon URL (or null in case the favicon is not available)
/// [id] is a 24-length randomly generated ID
/// [tags] stores a [List] of [String], which correspond to [Tag] [id]s
/// [otp] store the [Otp] model (if a 2fa entry is setup)
/// [Entry] and its children are JSON and MsgPack serializable
class Entry {
  int colorId;
  String name;
  String username;
  String password;
  String note;
  String favicon;
  String id;
  List<String> tags;
  Otp otp;

  Entry({
    this.colorId,
    this.name,
    this.username,
    this.password,
    this.note,
    this.favicon,
    this.otp,
    this.tags,
    this.id,
  });

  Entry.fromJson(Map<String, dynamic> json) {
    colorId = json['c'];
    name = json['n'];
    username = json['u'];
    password = json['p'];
    note = json['no'];
    favicon = json['f'];
    id = json['i'];
    tags = json['t'] != null ? json['t'].cast<String>() : [];
    otp = json['o'] != null
        ? Otp.fromJson(json['o'].cast<String, dynamic>())
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['c'] = colorId;
    data['n'] = name;
    data['u'] = username;
    data['p'] = password;
    data['no'] = note;
    data['f'] = favicon;
    data['i'] = id;
    data['t'] = tags;
    if (otp != null) {
      data['o'] = otp.toJson();
    }
    return data;
  }
}
