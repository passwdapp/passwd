import 'package:flutter/material.dart';

/// A sick looking FAB
///
/// Not used as of now
class CornerFloatingActionButton extends StatelessWidget {
  final Widget child;
  final double height;
  final bool beveled;
  final Color foregroundColor;
  final Color backgroundColor;
  final Widget icon;
  final double elevation;
  final double cornerRadius;
  final VoidCallback onTap;

  CornerFloatingActionButton({
    @required this.child,
    this.height = 56,
    this.beveled = false,
    this.foregroundColor,
    this.backgroundColor,
    @required this.icon,
    this.elevation = 4,
    this.cornerRadius = 28,
    this.onTap,
  }) : assert(cornerRadius <= height / 2);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final floatingActionButtonTheme = theme.floatingActionButtonTheme;

    final foregroundColor = this.foregroundColor ??
        floatingActionButtonTheme.foregroundColor ??
        theme.colorScheme.onSecondary;
    final backgroundColor = this.backgroundColor ??
        floatingActionButtonTheme.backgroundColor ??
        theme.colorScheme.secondary;

    return Stack(
      children: [
        child,
        Align(
          alignment: Alignment.bottomRight,
          child: Material(
            color: backgroundColor,
            elevation: elevation,
            clipBehavior: Clip.antiAlias,
            shape: beveled
                ? BeveledRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(cornerRadius),
                    ),
                  )
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(cornerRadius),
                    ),
                  ),
            child: SizedBox.fromSize(
              size: Size(height * 1.07, height),
              child: InkWell(
                child: IconTheme.merge(
                  data: IconThemeData(
                    color: foregroundColor,
                  ),
                  child: icon,
                ),
                onTap: onTap,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
