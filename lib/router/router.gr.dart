// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/entry.dart';
import '../screens/account_details/account_details_screen.dart';
import '../screens/add_account/add_account_screen.dart';
import '../screens/add_otp/add_otp_screen.dart';
import '../screens/generate_password/generate_password_screen.dart';
import '../screens/get_started/get_started_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/init/init_screen.dart';
import '../screens/set_pin/set_pin_screen.dart';
import '../screens/verify_pin/verify_pin_screen.dart';

class Routes {
  static const String initScreen = '/';
  static const String getStartedScreen = '/get-started-screen';
  static const String setPinScreen = '/set-pin-screen';
  static const String verifyPinScreen = '/verify-pin-screen';
  static const String homeScreen = '/home-screen';
  static const String addAccountScreen = '/add-account-screen';
  static const String generatePasswordScreen = '/generate-password-screen';
  static const String accountDetailsScreen = '/account-details-screen';
  static const String addOtpScreen = '/add-otp-screen';
  static const all = <String>{
    initScreen,
    getStartedScreen,
    setPinScreen,
    verifyPinScreen,
    homeScreen,
    addAccountScreen,
    generatePasswordScreen,
    accountDetailsScreen,
    addOtpScreen,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.initScreen, page: InitScreen),
    RouteDef(Routes.getStartedScreen, page: GetStartedScreen),
    RouteDef(Routes.setPinScreen, page: SetPinScreen),
    RouteDef(Routes.verifyPinScreen, page: VerifyPinScreen),
    RouteDef(Routes.homeScreen, page: HomeScreen),
    RouteDef(Routes.addAccountScreen, page: AddAccountScreen),
    RouteDef(Routes.generatePasswordScreen, page: GeneratePasswordScreen),
    RouteDef(Routes.accountDetailsScreen, page: AccountDetailsScreen),
    RouteDef(Routes.addOtpScreen, page: AddOtpScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    InitScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => InitScreen(),
        settings: data,
      );
    },
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
    VerifyPinScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => VerifyPinScreen(),
        settings: data,
      );
    },
    HomeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeScreen(),
        settings: data,
      );
    },
    AddAccountScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddAccountScreen(),
        settings: data,
      );
    },
    GeneratePasswordScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => GeneratePasswordScreen(),
        settings: data,
      );
    },
    AccountDetailsScreen: (data) {
      final args = data.getArgs<AccountDetailsScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AccountDetailsScreen(entry: args.entry),
        settings: data,
      );
    },
    AddOtpScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddOtpScreen(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// AccountDetailsScreen arguments holder class
class AccountDetailsScreenArguments {
  final Entry entry;
  AccountDetailsScreenArguments({@required this.entry});
}
