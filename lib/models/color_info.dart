import 'package:flutter/cupertino.dart';

/// [ColorInfo] is used to store the information of the tag colors
/// [localizationTag] here is used to localize the color names
class ColorInfo {
  Color color;
  String localizationTag;

  ColorInfo({this.color, this.localizationTag})
      : assert(color != null),
        assert(localizationTag != null);
}
