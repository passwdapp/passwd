import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:supercharged/supercharged.dart';

import '../../widgets/pin_input.dart';
import 'verify_pin_viewmodel.dart';

class VerifyPinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyPinViewModel>.reactive(
      viewModelBuilder: () => VerifyPinViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              model.error.isEmpty
                  ? context.getString("enter_pin")
                  : model.error,
              style: Theme.of(context).textTheme.headline5.copyWith(
                    fontWeight: FontWeight.w900,
                    color: model.error.isEmpty
                        ? Theme.of(context).textTheme.headline5.color
                        : Colors.red[300],
                  ),
            ),
            SizedBox(
              height: 32,
            ),
            PinInputWidget(
              onSubmit: (String value) {
                model.pin = value.toInt();
              },
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
                          contentPadding: const EdgeInsets.all(0),
                          trailing: Text(
                            context.getString("biometrics_retry"),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          onTap: () {
                            model.tryBiometrics();
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
      ),
    );
  }
}
