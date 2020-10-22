import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

import '../models/color_info.dart';

// These are the main colors of the app
final primaryColor = '#00ECD7'.toColor();
final canvasColor = '#121212'.toColor();
final primaryColorHovered = '#00AFA0'.toColor();

// These are used when no favicon is available
final iconColors = <Color>[
  Color(0xff49306B),
  Color(0xff6B2D5C),
  Color(0xffEE277C),
  Color(0xffCD133B),
  Color(0xff136A8A),
  Color(0xffE2285F),
  Color(0xff7b4397),
  Color(0xffB24592),
];

// These are used for tags
final tagColors = <ColorInfo>[
  ColorInfo(
    color: '#F44336'.toColor(),
    localizationTag: 'color_red',
  ),
  ColorInfo(
    color: '#F57C00'.toColor(),
    localizationTag: 'color_orange',
  ),
  ColorInfo(
    color: '#FFB300'.toColor(),
    localizationTag: 'color_green',
  ),
  ColorInfo(
    color: '#4CAf50'.toColor(),
    localizationTag: 'color_cyan',
  ),
  ColorInfo(
    color: '#00ACC1'.toColor(),
    localizationTag: 'color_light_blue',
  ),
  ColorInfo(
    color: '#1E88E5'.toColor(),
    localizationTag: 'color_blue',
  ),
  ColorInfo(
    color: '#9C27B0'.toColor(),
    localizationTag: 'color_purple',
  ),
  ColorInfo(
    color: '#E91E63'.toColor(),
    localizationTag: 'color_pink',
  ),
];
