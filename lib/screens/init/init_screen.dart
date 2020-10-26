import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../redux/actions/autofill.dart';
import '../../services/authentication/authentication_service.dart';
import '../../services/locator.dart';
import '../../widgets/title.dart';
import '../get_started/get_started_screen.dart';
import '../verify_pin/verify_pin_screen.dart';

class InitScreen extends StatefulWidget {
  final bool dispatchAutofill;

  const InitScreen({this.dispatchAutofill = false});

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  Future<bool> get isAuthenticated async {
    await locator.allReady();
    return await locator<AuthenticationService>().isAppSetup();
  }

  Future navigate() async {
    if (await isAuthenticated) {
      await Future.delayed(
        Duration(milliseconds: widget.dispatchAutofill ? 250 : 750),
      );
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
    if (widget.dispatchAutofill) {
      Provider.of<DispatchFuture>(
        context,
        listen: false,
      )(AutoFillLaunchTypeAction());
    }

    return Scaffold(
      body: Center(
        child: TitleWidget(
          textSize: 44,
        ),
      ),
    );
  }
}
