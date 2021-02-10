import 'dart:io';

import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';

import '../models/export.dart';
import '../services/export/export_service.dart';
import '../services/locator.dart';
import '../utils/loggers.dart';

class ExportSettingsWidget extends StatelessWidget {
  Future<void> showExportSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        child: Wrap(
          children: [
            ListTile(
              title: Text('Share Unencrypted'), // TODO: localize
              onTap: () async {
                Navigator.of(context).pop();
                await exportShareUnencrypted(context);
              },
            ),
            ListTile(
              title: Text('Share Encrypted'), // TODO: localize
              onTap: () async {
                Navigator.of(context).pop();
                await exportShareEncrypted(context);
              },
            ),
            ListTile(
              title: Text(context.getString('cancel')),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> exportShareEncrypted(BuildContext context) async {
    Loggers.mainLogger.info(
      'Export Type SHARE_ENCRYPTED',
    );
    await locator<ExportService>().export(ExportType.SHARE_ENCRYPTED);
  }

  Future<void> exportShareUnencrypted(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'), // TODO: localize
        content:
            Text('The database export will be unencrypted'), // TODO: localize
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(context.getString('no')),
          ),
          TextButton(
            onPressed: () async {
              Loggers.mainLogger.info(
                'Export Type SHARE_UNENCRYPTED',
              );
              Navigator.of(context).pop();
              await locator<ExportService>()
                  .export(ExportType.SHARE_UNENCRYPTED);
            },
            child: Text(context.getString('yes')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid || Platform.isIOS) {
      return ListTile(
        title: Text('Export'), // TODO: localize
        onTap: () async {
          Loggers.mainLogger.info(
            'Export exportService requested',
          );
          await showExportSheet(context);
        },
      );
    }

    return Container();
  }
}
