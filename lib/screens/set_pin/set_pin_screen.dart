import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:passwd/constants/colors.dart';
import 'package:passwd/screens/set_pin/set_pin_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:supercharged/supercharged.dart';

class SetPinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetPinViewModel>.reactive(
      viewModelBuilder: () => SetPinViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Set a pin",
              style: Theme.of(context).textTheme.headline5.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            SizedBox(
              height: 32,
            ),
            OtpTextField(
              filled: true,
              obscureText: false,
              fillColor: Colors.white.withOpacity(0.18),
              borderColor: Colors.transparent,
              cursorColor: primaryColor,
              showFieldAsBox: true,
              autoFocus: true,
              numberOfFields: 4,
              onCodeChanged: (String value) {},
              onSubmit: (String value) {
                model.pin = value.toInt();
              },
              hasCustomInputDecoration: false,
              textStyle: Theme.of(context).textTheme.headline6,
              enabledBorderColor: Colors.transparent,
              focusedBorderColor: Colors.transparent,
              fieldWidth: 64,
            ),
            FutureBuilder<bool>(
              future: model.biometricsAvailable(),
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
                          contentPadding: EdgeInsets.all(0),
                          title: Text("Enable biometrics"),
                          trailing: Switch(
                            value: model.biometrics,
                            onChanged: (bool value) {
                              model.setBiometrics(value);
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
          onPressed: model.nextEnabled
              ? () {
                  print("Enabled");
                }
              : null,
          label: Text("Next"),
          icon: Icon(Icons.chevron_right),
          disabledElevation: 0.0,
          elevation: 52.0,
        ),
      ),
    );
  }
}
