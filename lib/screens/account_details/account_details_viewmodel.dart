import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../services/locator.dart';

class AccountDetailsViewModel extends ChangeNotifier {
  bool _passwordVisible = false;
  bool get passwordVisible => _passwordVisible;

  set passwordVisible(bool passwordVisible) {
    _passwordVisible = passwordVisible;
    notifyListeners();
  }

  void pop() {
    locator<NavigationService>().back();
  }

  void copy(String text) {
    Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );
  }
}
