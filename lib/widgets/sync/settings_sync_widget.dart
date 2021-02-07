import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../redux/appstate.dart';
import '../../screens/setup_sync/setup_sync_screen.dart';

class SettingsSyncWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      leading: Icon(
        state.isLoggedIn ? Icons.sync_outlined : Icons.sync_disabled_outlined,
      ),
      title: Text(
        state.isLoggedIn
            ? context.getString('sync_enabled')
            : context.getString('setup_sync'),
      ),
      onTap: state.isLoggedIn
          ? null
          : () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SetupSyncScreen(),
              ));
            },
    );
  }
}
