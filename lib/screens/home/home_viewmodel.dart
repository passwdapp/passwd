import 'package:flutter/foundation.dart';
import 'package:passwd/router/router.gr.dart';
import 'package:passwd/services/locator.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ChangeNotifier {
  void toAdd() {
    locator<NavigationService>().navigateTo(Routes.addAccountScreen);
  }
}
