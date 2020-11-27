import 'dart:io';

import 'package:autofill_service/autofill_service.dart';
import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../utils/loggers.dart';
import '../../widgets/sync/settings_sync_widget.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final settingsItems = <Widget>[
    if (Platform.isAndroid)
      ListTile(
        title: Text('Activate autofill service'),
        onTap: () async {
          final response = await AutofillService().requestSetAutofillService();
          Loggers.mainLogger.info(
            'Autofill requestSetAutofillService: ${response}',
          );
        },
      ),
    SettingsSyncWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(
            letterSpacing: 1.25,
            fontSize: 18,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          tooltip: context.getString('back_tooltip'),
          icon: Icon(Feather.x_circle),
        ),
      ),
      body: ListView.builder(
        itemCount: settingsItems.length,
        itemBuilder: (context, i) => settingsItems[i],
      ),
    );
  }
}
