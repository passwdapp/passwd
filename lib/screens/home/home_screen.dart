import 'package:flutter/material.dart';
import 'package:passwd/screens/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text("Passwd"),
        ),
      ),
    );
  }
}
