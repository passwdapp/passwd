import 'package:flutter/foundation.dart';
import 'package:passwd/services/locator.dart';
import 'package:stacked_services/stacked_services.dart';

class AccountDetailsViewModel extends ChangeNotifier {
  void pop() {
    locator<NavigationService>().back();
  }
}
