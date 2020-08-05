import 'package:flutter/foundation.dart';
import 'package:passwd/services/locator.dart';
import 'package:passwd/services/password/password_service.dart';
import 'package:stacked_services/stacked_services.dart';

class GeneratePasswordViewModel extends ChangeNotifier {
  String _password = "";
  String get password => _password;

  set password(String password) {
    _password = password;
    notifyListeners();
  }

  void pop() {
    locator<NavigationService>().back(result: "");
  }

  void popWithPassword(String password) {
    locator<NavigationService>().back(result: password);
  }

  Future<String> getDicewarePassword({
    int words = 5,
    bool capitalize = true,
  }) async {
    return await locator<PasswordService>().generateDicewarePassword(
      words: words,
      capitalize: capitalize,
    );
  }
}
