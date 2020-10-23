import 'package:autofill_service/autofill_service.dart';
import 'package:flutter/material.dart';

import '../../utils/loggers.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final settingsItems = <Widget>[
    ListTile(
      title: Text('Activate autofill service'),
      onTap: () async {
        final response = await AutofillService().requestSetAutofillService();
        Loggers.mainLogger.info(
          'Autofill requestSetAutofillService: ${response}',
        );
      },
    ),
  ];

  Future getState() async {
    print(await AutofillService().hasEnabledAutofillServices);
  }

  @override
  Widget build(BuildContext context) {
    getState();
    return Scaffold(
      body: ListView.builder(
        itemCount: settingsItems.length,
        itemBuilder: (context, i) => settingsItems[i],
      ),
    );
  }
}
