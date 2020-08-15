import 'package:flutter/foundation.dart';
import 'package:passwd/services/locator.dart';
import 'package:stacked_services/stacked_services.dart';

class AddOtpViewModel extends ChangeNotifier {
  void pop() {
    locator<NavigationService>().back();
  }
}
