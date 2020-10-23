import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

class Loggers {
  static final mainLogger = Logger('main');
  static final networkLogger = Logger('network');
  static final faviconLogger = Logger('favicon');
  static final syncLogger = Logger('sync');
}

void setupLogging() {
  Logger.root.level = Level.ALL;
  PrintAppender()..attachToLogger(Logger.root);
}
