import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'locator.config.dart';

GetIt locator = GetIt.instance;

@injectableInit
void initializeLocator([String env = "mobile"]) =>
    $initGetIt(locator, environment: env);
