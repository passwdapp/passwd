import 'package:flutter/material.dart';

import '../../services/authentication/authentication_service.dart';
import '../../services/locator.dart';
import '../../widgets/title.dart';
import '../get_started/get_started_screen.dart';
import '../verify_pin/verify_pin_screen.dart';

class InitScreen extends StatefulWidget {
  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  Future<bool> isAuthenticated() async {
    await locator.allReady();
    final key = await locator<AuthenticationService>().readEncryptionKey();
    return key != null;
  }

  Future navigate() async {
    if (await isAuthenticated()) {
      await Future.delayed(Duration(milliseconds: 750));
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => VerifyPinScreen(),
        ),
      );
    } else {
      await Future.delayed(Duration(milliseconds: 1500));
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => GetStartedScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TitleWidget(
          textSize: 44,
        ),
      ),
    );
  }
}
