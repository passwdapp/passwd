import 'package:flutter/cupertino.dart';

class ColorInfo {
  Color color;
  String localizationTag;

  ColorInfo({this.color, this.localizationTag})
      : assert(color != null),
        assert(localizationTag != null);
}
