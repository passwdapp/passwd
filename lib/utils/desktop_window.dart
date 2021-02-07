import 'dart:ui';

import 'package:desktop_window/desktop_window.dart';

import 'loggers.dart';

Future setupDesktopWindow() async {
  await DesktopWindow.setMinWindowSize(Size(400, 400));
  await DesktopWindow.setMaxWindowSize(Size(500, 940));
  await DesktopWindow.setWindowSize(Size(460, 800));

  Loggers.mainLogger.info('Desktop window initialized');
}
