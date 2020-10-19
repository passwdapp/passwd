import 'package:flutter/material.dart';

import '../../models/sizing_information.dart';
import '../../utils/get_device_type.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    SizingInformation sizingInformation,
  ) builder;

  const ResponsiveBuilder({@required this.builder}) : assert(builder != null);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        MediaQueryData query = MediaQuery.of(context);
        SizingInformation information = SizingInformation(
          deviceType: getDeviceType(query),
          screenSize: query.size,
          localWidgetSize: Size(
            constraints.maxWidth,
            constraints.maxHeight,
          ),
        );

        return builder(context, information);
      },
    );
  }
}
