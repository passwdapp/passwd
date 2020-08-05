import 'package:flutter/material.dart';
import 'package:passwd/screens/init/init_viewmodel.dart';
import 'package:passwd/widgets/title.dart';
import 'package:stacked/stacked.dart';

class InitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InitViewModel>.nonReactive(
      viewModelBuilder: () => InitViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: TitleWidget(
            textSize: 44,
          ),
        ),
      ),
    );
  }
}
