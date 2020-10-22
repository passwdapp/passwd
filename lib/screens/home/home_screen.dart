import 'package:async_redux/async_redux.dart' hide ViewModelBuilder;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../redux/actions/entries.dart';
import '../home_passwords/home_passwords_sceeen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<DispatchFuture>(
      context,
      listen: false,
    )(ReloadAction(reloadFromDisk: true));

    return HomePasswordsScreen();
  }
}
