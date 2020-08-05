import 'package:flutter/foundation.dart';
import 'package:passwd/services/locator.dart';
import 'package:stacked_services/stacked_services.dart';

class AddAccountViewModel extends ChangeNotifier {
  String _name;
  String get name => _name;

  set name(String name) {
    _name = name;
    notifyListeners();
  }

  String _username;
  String get username => _username;

  set username(String username) {
    _username = username;
    notifyListeners();
  }

  String _password;
  String get password => _password;

  set password(String password) {
    _password = password;
    notifyListeners();
  }

  String _notes;
  String get notes => _notes;

  set notes(String notes) {
    _notes = notes;
    notifyListeners();
  }

  void pop() {
    locator<NavigationService>().back();
  }
}
