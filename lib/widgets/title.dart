import 'package:flutter/material.dart';

import '../constants/colors.dart';

class TitleWidget extends StatelessWidget {
  final double textSize;
  final MainAxisAlignment mainAxisAlignment;

  TitleWidget({
    this.textSize = 36,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
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
                color: primaryColor,
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
