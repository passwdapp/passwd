import 'package:passwd/models/otp.dart';

class Entry {
  String name;
  String username;
  String password;
  String note;
  String favicon;
  Otp otp;

  Entry({
    this.name,
    this.username,
    this.password,
    this.note,
    this.favicon,
    this.otp,
  });

  Entry.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    password = json['password'];
    note = json['note'];
    favicon = json['favicon'];
    otp = json['otp'] != null ? Otp.fromJson(json['otp']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['password'] = this.password;
    data['note'] = this.note;
    data['favicon'] = this.favicon;
    if (this.otp != null) {
      data['otp'] = this.otp.toJson();
    }
    return data;
  }
}
