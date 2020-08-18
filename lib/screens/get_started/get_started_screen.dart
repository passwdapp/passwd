import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:passwd/screens/get_started/get_started_viewmodel.dart';
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
                context.getString("get_started"),
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
