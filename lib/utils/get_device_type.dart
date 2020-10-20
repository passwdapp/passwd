import 'package:flutter/widgets.dart';

import '../models/device_type.dart';

/// [getDeviceType] returns [DeviceType] after processing the supplied [MediaQueryData]
/// This is deprecated and is not used in the app
@deprecated
DeviceType getDeviceType(MediaQueryData data) {
  final deviceWidth = data.size.shortestSide;

  if (deviceWidth > 600 && deviceWidth <= 950) {
    return DeviceType.TABLET;
  }

  if (deviceWidth > 950) {
    return DeviceType.DESKTOP;
  }

  return DeviceType.MOBILE;
}
