import 'package:flutter/foundation.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../router/router.gr.dart';
import '../../services/locator.dart';

class GetStartedViewModel extends ChangeNotifier {
  void handleClick() {
    locator<NavigationService>().navigateTo(Routes.setPinScreen);
  }
}
