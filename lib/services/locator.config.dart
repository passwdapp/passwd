// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/get_it_helper.dart';
import 'package:stacked_services/stacked_services.dart';

import 'biometrics/biometrics_localauth.dart';
import 'biometrics/biometrics_service.dart';
import 'third_party.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

void $initGetIt(GetIt g, {String environment}) {
  final gh = GetItHelper(g, environment);
  final thirdPartySevices = _$ThirdPartySevices();
  gh.lazySingleton<BiometricsService>(() => BiometricsLocalAuth());
  gh.lazySingleton<NavigationService>(
      () => thirdPartySevices.navigationService);
}

class _$ThirdPartySevices extends ThirdPartySevices {
  @override
  NavigationService get navigationService => NavigationService();
}
