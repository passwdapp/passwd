import 'package:flutter/material.dart';

import '../../models/device_type.dart';
import 'responsive_builder.dart';

class ScreenTypeBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;
  final Widget tablet;

  ScreenTypeBuilder({
    @required this.mobile,
    this.desktop,
    this.tablet,
  }) : assert(mobile != null);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, information) {
        if (information.deviceType == DeviceType.DESKTOP && desktop != null) {
          return desktop;
        }

        if (information.deviceType == DeviceType.TABLET && tablet != null) {
          return tablet;
        }

        return mobile;
      },
    );
  }
}
