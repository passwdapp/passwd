import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Widget child;
  final void Function() onClick;

  Button({
    @required this.child,
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onClick,
      child: child,
      visualDensity: VisualDensity(
        horizontal: 4,
        vertical: 2,
      ),
    );
  }
}
