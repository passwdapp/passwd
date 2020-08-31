import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passwd/constants/colors.dart';
import 'package:passwd/constants/theme.dart';
import 'package:passwd/router/router.gr.dart' as router;
import 'package:passwd/services/locator.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  initializeLocator();
  runApp(MyApp());
}

void runDesktop() {
  initializeLocator("desktop");
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
          Locale("pl"),
        ],
      ),
      builder: (context, localizationDelegate) => MaterialApp(
        title: "Passwd",
        localizationsDelegates: localizationDelegate.localizationDelegates,
        supportedLocales: localizationDelegate.supportedLocales,
        localeResolutionCallback: localizationDelegate.localeResolutionCallback,
        theme: ThemeData.dark().copyWith(
          primaryColor: primaryColor,
          accentColor: primaryColor,
          iconTheme: IconThemeData(
            color: ThemeData.dark().iconTheme.color,
          ),
          textTheme: textTheme,
          // visualDensity: VisualDensity.adaptivePlatformDensity,
          pageTransitionsTheme: pageTransitionsTheme,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: primaryColor,
          ),
          appBarTheme: appBarTheme.copyWith(
            brightness: Brightness.dark,
            iconTheme: IconThemeData(
              color: ThemeData.dark().textTheme.bodyText1.color,
            ),
          ),
          canvasColor: canvasColor,
          scaffoldBackgroundColor: canvasColor,
          bottomNavigationBarTheme:
              ThemeData.dark().bottomNavigationBarTheme.copyWith(
                    backgroundColor: Colors.white,
                    elevation: 4,
                  ),
          cursorColor: primaryColor,
          buttonTheme: ButtonThemeData(
            buttonColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            hoverColor: primaryColorHovered,
            highlightColor: primaryColorHovered,
          ),
          backgroundColor: canvasColor,
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(
              fontSize: 14,
              letterSpacing: 1.5,
            ),
          ),
          dialogTheme: dialogTheme,
          snackBarTheme: SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
          ),
        ),
        builder: (context, child) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              systemNavigationBarColor: canvasColor,
              systemNavigationBarIconBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
              statusBarColor: Colors.transparent,
            ),
          );

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
