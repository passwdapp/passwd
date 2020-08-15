import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:passwd/screens/add_otp/add_otp_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AddOtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddOtpViewModel>.reactive(
      viewModelBuilder: () => AddOtpViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add an Account",
            style: TextStyle(
              letterSpacing: 1.25,
              fontSize: 18,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              model.pop();
            },
            tooltip: "Back",
            icon: Icon(Feather.x_circle),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              tooltip: "Done",
              icon: Icon(Feather.check_circle),
            ),
          ],
        ),
      ),
    );
  }
}
