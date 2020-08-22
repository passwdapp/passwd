import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final double textSize;

  TitleWidget({this.textSize = 36});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Pass",
          style: Theme.of(context).textTheme.headline4.copyWith(
                fontSize: textSize,
                fontWeight: FontWeight.w900,
              ),
        ),
        Text(
          "wd",
          style: Theme.of(context).textTheme.headline4.copyWith(
                color: Theme.of(context).primaryColor,
                fontSize: textSize,
                fontWeight: FontWeight.w900,
              ),
        ),
        Text(
          ".",
          style: Theme.of(context).textTheme.headline4.copyWith(
                fontSize: textSize,
                fontWeight: FontWeight.w900,
              ),
        ),
      ],
    );
  }
}
