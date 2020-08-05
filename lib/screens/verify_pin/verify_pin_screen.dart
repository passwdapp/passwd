import 'package:flutter/material.dart';
import 'package:passwd/screens/verify_pin/verify_pin_viewmodel.dart';
import 'package:passwd/widgets/pin_input.dart';
import 'package:stacked/stacked.dart';
import 'package:supercharged/supercharged.dart';

class VerifyPinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyPinViewModel>.reactive(
      viewModelBuilder: () => VerifyPinViewModel(),
      builder: (context, model, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            model.error.isEmpty ? "Please enter your pin" : model.error,
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
                        contentPadding: EdgeInsets.all(0),
                        title: Text("Retry with biometrics"),
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
