import 'package:flutter/material.dart';
import 'package:passwd/screens/get_started/get_started_screen.dart';
import 'package:passwd/screens/home/home_screen.dart';
import 'package:passwd/services/authentication/authentication_service.dart';
import 'package:passwd/services/locator.dart';

class InitScreen extends StatelessWidget {
  Future<bool> isAuthenticated() async {
    await locator.allReady();
    String key = await locator<AuthenticationService>().readEncryptionKey();

    return key != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isAuthenticated(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            return HomeScreen();
          } else {
            return GetStartedScreen();
          }
        }

        return Container();
      },
    );
  }
}
