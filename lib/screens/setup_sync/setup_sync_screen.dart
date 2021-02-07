import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/title.dart';
import '../sync_auth/sync_auth_screen.dart';

class SetupSyncScreen extends StatefulWidget {
  @override
  _SetupSyncScreenState createState() => _SetupSyncScreenState();
}

class _SetupSyncScreenState extends State<SetupSyncScreen> {
  void push(bool register) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => SyncAuthScreen(register: register),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          tooltip: context.getString('back_tooltip'),
          icon: Icon(Feather.x_circle),
        ),
        actions: [
          IconButton(
            icon: Icon(Feather.info),
            onPressed: () async {
              await launch('https://github.com/passwdapp/box');
            },
            tooltip: 'Documentation', // TODO: localize
          ),
        ],
      ),
      body: Column(
        children: [
          // TODO: localize
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TitleWidget(),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Sync Beta',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Theme.of(context).canvasColor,
                        ),
                      ),
                      onPressed: () {
                        push(false);
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: OutlineButton(
                      child: Text(
                        'Register',
                      ),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        push(true);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
