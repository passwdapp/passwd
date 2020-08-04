import 'package:passwd/models/otp.dart';

class Entry {
  String name;
  String username;
  String password;
  String note;
  String uri;
  String favicon;
  Otp otp;

  Entry({
    this.name,
    this.username,
    this.password,
    this.note,
    this.uri,
    this.favicon,
    this.otp,
  });

  Entry.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    password = json['password'];
    note = json['note'];
    uri = json['uri'];
    favicon = json['favicon'];
    otp = json['otp'] != null ? new Otp.fromJson(json['otp']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['password'] = this.password;
    data['note'] = this.note;
    data['uri'] = this.uri;
    data['favicon'] = this.favicon;
    if (this.otp != null) {
      data['otp'] = this.otp.toJson();
    }
    return data;
  }
}
