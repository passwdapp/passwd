import 'package:flutter/material.dart';
import 'package:passwd/screens/onboarding/get_started/get_started_viewmodel.dart';
import 'package:passwd/widgets/title.dart';
import 'package:stacked/stacked.dart';
import 'package:supercharged/supercharged.dart';

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GetStartedViewModel>.nonReactive(
      viewModelBuilder: () => GetStartedViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleWidget(),
            SizedBox(
              height: 32,
            ),
            RaisedButton(
              onPressed: model.handleClick,
              child: Text(
                "Get Started",
                style: TextStyle(
                  color: "#121212".toColor(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
