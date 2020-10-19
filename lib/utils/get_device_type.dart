import 'package:flutter/widgets.dart';

import '../models/device_type.dart';

DeviceType getDeviceType(MediaQueryData data) {
  double deviceWidth = data.size.shortestSide;

  if (deviceWidth > 600 && deviceWidth <= 950) {
    return DeviceType.TABLET;
  }

  if (deviceWidth > 950) {
    return DeviceType.DESKTOP;
  }

  return DeviceType.MOBILE;
}
