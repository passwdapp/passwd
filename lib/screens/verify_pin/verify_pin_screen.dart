import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

import '../../services/authentication/authentication_service.dart';
import '../../services/biometrics/biometrics_service.dart';
import '../../services/locator.dart';
import '../../widgets/pin_input.dart';
import '../home/home_screen.dart';

class VerifyPinScreen extends StatefulWidget {
  @override
  _VerifyPinScreenState createState() => _VerifyPinScreenState();
}

class _VerifyPinScreenState extends State<VerifyPinScreen> {
  String error = '';

  Future<bool> biometricsAvailable() async {
    if (await locator<AuthenticationService>().allowBiometrics() &&
        await locator<BiometricsService>().biometricsAvailable()) {
      return true;
    } else {
      return false;
    }
  }

  Future tryBiometrics() async {
    if (await biometricsAvailable()) {
      try {
        if (await locator<AuthenticationService>().comparePin(null)) {
          replace();
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future verifyPin(int pin) async {
    var valid = await locator<AuthenticationService>().comparePin(pin);

    if (valid) {
      replace();
    } else {
      setState(() {
        error = 'Invalid pin entered';
      });
    }
  }

  void replace() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => HomeScreen(),
      ),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();

    tryBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            error.isEmpty ? context.getString('enter_pin') : error,
            style: Theme.of(context).textTheme.headline5.copyWith(
                  fontWeight: FontWeight.w900,
                  color: error.isEmpty
                      ? Theme.of(context).textTheme.headline5.color
                      : Colors.red[300],
                ),
          ),
          SizedBox(
            height: 32,
          ),
          PinInputWidget(
            onSubmit: (String value) {
              verifyPin(value.toInt());
            },
          ),
          FutureBuilder<bool>(
            future: biometricsAvailable(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data) {
                return Column(
                  children: [
                    SizedBox(
                      height: 6,
                    ),
                    Container(
                      width: 284,
                      child: ListTile(
                        leading: Icon(
                          Icons.fingerprint_outlined,
                        ),
                        contentPadding: const EdgeInsets.all(0),
                        trailing: Text(
                          context.getString('biometrics_retry'),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        onTap: () {
                          tryBiometrics();
                        },
                      ),
                    ),
                  ],
                );
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }
}
