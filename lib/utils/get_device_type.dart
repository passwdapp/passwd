import 'package:flutter/widgets.dart';
import 'package:passwd/models/device_type.dart';

DeviceType getDeviceType(MediaQueryData data) {
  double deviceWidth = data.size.shortestSide;

  if (deviceWidth > 950) {
    return DeviceType.DESKTOP;
  }

  if (deviceWidth > 600) {
    return DeviceType.TABLET;
  }

  return DeviceType.MOBILE;
}
