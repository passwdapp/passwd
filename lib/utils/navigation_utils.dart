import 'package:flutter/material.dart';

// TODO: Move navigation to this util
Future<dynamic> navigate(
  BuildContext context,
  Widget to, {
  double width = 500,
  double height = 840,
}) async {
  return await Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => to),
  );
}
