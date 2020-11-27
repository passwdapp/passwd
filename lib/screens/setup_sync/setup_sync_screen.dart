import 'package:flutter/material.dart';
import 'package:passwd/widgets/title.dart';

class SetupSyncScreen extends StatefulWidget {
  @override
  _SetupSyncScreenState createState() => _SetupSyncScreenState();
}

class _SetupSyncScreenState extends State<SetupSyncScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TitleWidget(),
            ),
          ),
          Expanded(
            child: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
