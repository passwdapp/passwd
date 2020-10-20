import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

import '../../widgets/title.dart';
import '../set_pin/set_pin_screen.dart';

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TitleWidget(),
          SizedBox(
            height: 32,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SetPinScreen(),
                ),
              );
            },
            child: Text(
              context.getString('get_started'),
              style: TextStyle(
                color: '#121212'.toColor(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
