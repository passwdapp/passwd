import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SyncAuthScreen extends StatefulWidget {
  final bool register;

  SyncAuthScreen({this.register = false});

  @override
  _SyncAuthScreenState createState() => _SyncAuthScreenState();
}

class _SyncAuthScreenState extends State<SyncAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          !widget.register ? 'Login' : 'Register', // TODO: localize
          style: TextStyle(
            letterSpacing: 1.25,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          tooltip: context.getString('back_tooltip'),
          icon: Icon(Feather.x_circle),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: context.getString('done_tooltip'),
            icon: Icon(Feather.check_circle),
          ),
        ],
      ),
    );
  }
}
