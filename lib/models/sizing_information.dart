import 'package:flutter/widgets.dart';

import 'device_type.dart';

/// [SizingInformation] was used to store (now deprecated) device size information
@deprecated
class SizingInformation {
  final DeviceType deviceType;
  final Size screenSize;
  final Size localWidgetSize;

  SizingInformation({
    this.deviceType,
    this.screenSize,
    this.localWidgetSize,
  });
}
