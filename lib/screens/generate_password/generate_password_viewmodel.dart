import 'package:flutter/foundation.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../services/locator.dart';
import '../../services/password/password_service.dart';

class GeneratePasswordViewModel extends ChangeNotifier {
  String _password = "";
  String get password => _password;

  set password(String password) {
    _password = password;
    notifyListeners();
  }

  int _words = 5;
  int get words => _words;

  set words(int words) {
    _words = words;
    notifyListeners();
  }

  bool _capitalize = true;
  bool get capitalize => _capitalize;

  set capitalize(bool capitalize) {
    _capitalize = capitalize;
    notifyListeners();
  }

  bool _diceware = true;
  bool get diceware => _diceware;

  set diceware(bool diceware) {
    _diceware = diceware;
    notifyListeners();
  }

  void pop() {
    locator<NavigationService>().back(result: "");
  }

  void popWithPassword(String password) {
    locator<NavigationService>().back(result: password);
  }

  Future<String> getPassword({
    int length = 5,
    bool capitalize = true,
  }) async {
    if (_diceware) {
      String password =
          await locator<PasswordService>().generateDicewarePassword(
        words: length,
        capitalize: capitalize,
      );

      _password = password;
      notifyListeners();

      return password;
    } else {
      String password = locator<PasswordService>().generateRandomPassword(
        length: length,
      );

      _password = password;
      notifyListeners();

      return password;
    }
  }
}
