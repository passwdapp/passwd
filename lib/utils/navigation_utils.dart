import 'package:flutter/material.dart';

// TODO: Move navigation to this util
Future<dynamic> navigate(
  BuildContext context,
  Widget to, {
  double width = 500,
  double height = 840,
}) async {
  final data = MediaQuery.of(context);
  if (data.size.shortestSide > 600) {
    return await showDialog(
      context: context,
      child: Center(
        child: SizedBox(
          height: height,
          width: width,
          child: Dialog(
            child: to,
          ),
        ),
      ),
    );
  } else {
    return await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => to),
    );
  }
}
