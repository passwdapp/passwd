import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/title.dart';
import 'init_viewmodel.dart';

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
