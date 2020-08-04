// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../screens/get_started/get_started_screen.dart';
import '../screens/set_pin/set_pin_screen.dart';

class Routes {
  static const String getStartedScreen = '/';
  static const String setPinScreen = '/set-pin-screen';
  static const all = <String>{
    getStartedScreen,
    setPinScreen,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.getStartedScreen, page: GetStartedScreen),
    RouteDef(Routes.setPinScreen, page: SetPinScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    GetStartedScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => GetStartedScreen(),
        settings: data,
      );
    },
    SetPinScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SetPinScreen(),
        settings: data,
      );
    },
  };
}
