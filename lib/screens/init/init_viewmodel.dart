import 'package:flutter/foundation.dart';
import 'package:passwd/router/router.gr.dart';
import 'package:passwd/services/authentication/authentication_service.dart';
import 'package:passwd/services/locator.dart';
import 'package:stacked_services/stacked_services.dart';

class InitViewModel extends ChangeNotifier {
  InitViewModel() {
    navigate();
  }

  Future<bool> isAuthenticated() async {
    await locator.allReady();
    String key = await locator<AuthenticationService>().readEncryptionKey();

    return key != null;
  }

  Future navigate() async {
    if (await isAuthenticated()) {
      await Future.delayed(Duration(milliseconds: 750));
      locator<NavigationService>().clearStackAndShow(Routes.verifyPinScreen);
    } else {
      await Future.delayed(Duration(milliseconds: 1500));
      locator<NavigationService>().clearStackAndShow(Routes.getStartedScreen);
    }
  }
}
