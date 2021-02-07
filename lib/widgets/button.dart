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
    return ElevatedButton(
      onPressed: onClick,
      child: child,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Colors.white.withOpacity(0.14)),
        visualDensity: VisualDensity(
          horizontal: 4,
          vertical: 2,
        ),
      ),
    );
  }
}
