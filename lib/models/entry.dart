import 'package:passwd/models/otp.dart';

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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['c'] = this.colorId;
    data['n'] = this.name;
    data['u'] = this.username;
    data['p'] = this.password;
    data['no'] = this.note;
    data['f'] = this.favicon;
    data['i'] = this.id;
    data['t'] = this.tags;
    if (this.otp != null) {
      data['o'] = this.otp.toJson();
    }
    return data;
  }
}
