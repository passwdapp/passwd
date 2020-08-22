import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passwd/constants/colors.dart';
import 'package:passwd/constants/theme.dart';
import 'package:passwd/router/router.gr.dart' as router;
import 'package:passwd/services/locator.dart';
import 'package:passwd/utils/is_dark.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  initializeLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EzLocalizationBuilder(
      delegate: EzLocalizationDelegate(
        supportedLocales: [
          Locale("en"),
          Locale("hi"),
          Locale("fr"),
          Locale("nl"),
        ],
      ),
      builder: (context, localizationDelegate) => MaterialApp(
        title: "Passwd",
        localizationsDelegates: localizationDelegate.localizationDelegates,
        supportedLocales: localizationDelegate.supportedLocales,
        localeResolutionCallback: localizationDelegate.localeResolutionCallback,
        theme: lightTheme,
        darkTheme: darkTheme,
        builder: (context, child) {
          if (isDark(context)) {
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                systemNavigationBarColor: canvasColor,
                systemNavigationBarIconBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.light,
                statusBarColor: Colors.transparent,
              ),
            );
          } else {
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                systemNavigationBarColor: canvasColorLight,
                systemNavigationBarIconBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.transparent,
              ),
            );
          }

          return child;
        },
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.Router(),
        initialRoute: router.Routes.initScreen,
        navigatorKey: locator<NavigationService>().navigatorKey,
      ),
    );
  }
}
