import 'package:flutter/material.dart';

class ResponsiveOrientationBuilder extends StatelessWidget {
  final Widget portrait;
  final Widget landscape;

  ResponsiveOrientationBuilder({
    @required this.portrait,
    this.landscape,
  }) : assert(portrait != null);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape && landscape != null) {
          return landscape;
        }

        return portrait;
      },
    );
  }
}
