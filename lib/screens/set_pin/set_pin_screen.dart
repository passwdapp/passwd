import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

import '../../models/biometrics_result.dart';
import '../../services/authentication/authentication_service.dart';
import '../../services/biometrics/biometrics_service.dart';
import '../../services/locator.dart';
import '../../widgets/pin_input.dart';
import '../home/home_screen.dart';

class SetPinScreen extends StatefulWidget {
  @override
  _SetPinScreenState createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  int pin;
  bool nextEnabled = false;
  bool biometrics = false;

  Future<void> setBiometrics(bool value) async {
    if (value) {
      final result = await locator<BiometricsService>()
          .authenticate(context.getString('enable_biometrics'));

      if (result == BiometricsResult.AUTHENTICATED) {
        biometrics = true;
      } else {
        biometrics = false;
      }
    } else {
      biometrics = false;
    }

    setState(() {});

    await locator<AuthenticationService>().writeBiometrics(biometrics);
  }

  Future<bool> biometricsAvailable() async {
    return await locator<BiometricsService>().biometricsAvailable();
  }

  Future next() async {
    await locator<AuthenticationService>().writePin(pin, biometrics);
    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => HomeScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            context.getString('set_pin'),
            style: Theme.of(context).textTheme.headline5.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          SizedBox(
            height: 32,
          ),
          PinInputWidget(
            onSubmit: (String value) {
              setState(() {
                pin = value.toInt();
                nextEnabled = true;
              });
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
                        title: Text(
                          context.getString('enable_biometrics'),
                        ),
                        trailing: Switch(
                          value: biometrics,
                          onChanged: (bool value) {
                            setBiometrics(value);
                          },
                        ),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: nextEnabled
            ? () {
                next();
              }
            : null,
        label: Text(
          context.getString('next'),
        ),
        icon: Icon(Icons.chevron_right),
        disabledElevation: 0.0,
        elevation: 52.0,
      ),
    );
  }
}
