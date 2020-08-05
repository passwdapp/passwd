import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:passwd/screens/add_account/add_account_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AddAccountScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddAccountViewModel>.reactive(
      viewModelBuilder: () => AddAccountViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text("Add an account"),
        ),
      ),
    );
  }
}
