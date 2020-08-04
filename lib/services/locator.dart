import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:passwd/services/locator.config.dart';

GetIt locator = GetIt.instance;

@injectableInit
void initializeLocator() => $initGetIt(locator);
