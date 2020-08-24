import 'package:flutter/material.dart';
import 'package:passwd/models/color_info.dart';
import 'package:supercharged/supercharged.dart';

Color primaryColor = "#00ECD7".toColor();
Color canvasColor = "#151618".toColor();
Color primaryColorHovered = "#00AFA0".toColor();

List<Color> iconColors = [
  Color(0xff49306B),
  Color(0xff6B2D5C),
  Color(0xffEE277C),
  Color(0xffCD133B),
  Color(0xff136A8A),
  Color(0xffE2285F),
  Color(0xff7b4397),
  Color(0xffB24592),
];

List<ColorInfo> tagColors = [
  ColorInfo(
    color: "#000000".toColor().withOpacity(0),
    localizationTag: "color_none",
  ),
  ColorInfo(
    color: "#5B2925".toColor(),
    localizationTag: "color_red",
  ),
  ColorInfo(
    color: "#5B5525".toColor(),
    localizationTag: "color_orange",
  ),
  ColorInfo(
    color: "#255B27".toColor(),
    localizationTag: "color_green",
  ),
  ColorInfo(
    color: "#255B53".toColor(),
    localizationTag: "color_cyan",
  ),
  ColorInfo(
    color: "#254A5B".toColor(),
    localizationTag: "color_light_blue",
  ),
  ColorInfo(
    color: "#252E5B".toColor(),
    localizationTag: "color_blue",
  ),
  ColorInfo(
    color: "#3A255B".toColor(),
    localizationTag: "color_purple",
  ),
  ColorInfo(
    color: "#5B2547".toColor(),
    localizationTag: "color_pink",
  ),
];
