import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:passwd/screens/generate_password/generate_password_viewmodel.dart';
import 'package:stacked/stacked.dart';

class GeneratePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GeneratePasswordViewModel>.reactive(
      viewModelBuilder: () => GeneratePasswordViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Password",
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
              onPressed: () {
                model.popWithPassword(model.password);
              },
              tooltip: "Done",
              icon: Icon(Feather.check_circle),
            ),
          ],
        ),
      ),
    );
  }
}
