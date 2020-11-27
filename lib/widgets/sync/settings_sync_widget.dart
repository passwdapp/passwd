import 'package:flutter/material.dart';

class SettingsSyncWidget extends StatefulWidget {
  @override
  SettingsSyncWidgetState createState() => SettingsSyncWidgetState();
}

class SettingsSyncWidgetState extends State<SettingsSyncWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 2,
        ),
        leading: Icon(Icons.sync_disabled_outlined),
        title: Text('Setup Sync'), // TODO: localize
      ),
    );
  }
}
