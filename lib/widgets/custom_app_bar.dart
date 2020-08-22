import 'package:flutter/material.dart';
import 'package:passwd/utils/is_dark.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String text;
  final Widget left;
  final Widget right;

  CustomAppBar({
    @required this.text,
    this.left,
    this.right,
  }) : assert(text != null);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        text,
        style: TextStyle(
          letterSpacing: 1.25,
          fontSize: 18,
          color: isDark(context)
              ? null
              : Theme.of(context).textTheme.bodyText1.color,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      leading: left,
      actions: [
        right,
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(64.0);
}
