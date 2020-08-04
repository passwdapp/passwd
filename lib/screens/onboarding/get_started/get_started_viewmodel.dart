import 'package:flutter/foundation.dart';
import 'package:passwd/router/router.gr.dart';
import 'package:passwd/services/locator.dart';
import 'package:stacked_services/stacked_services.dart';

class GetStartedViewModel extends ChangeNotifier {
  void handleClick() {
    locator<NavigationService>().navigateTo(Routes.setPinScreen);
  }
}
