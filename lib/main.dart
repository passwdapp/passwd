import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider_for_redux/provider_for_redux.dart';
import 'package:touch_bar/touch_bar.dart';
import 'package:touch_bar_macos/touch_bar_macos.dart';

import 'constants/colors.dart';
import 'constants/theme.dart';
import 'models/entries.dart';
import 'redux/appstate.dart';
import 'screens/init/init_screen.dart';
import 'services/locator.dart';
import 'utils/desktop_window.dart';
import 'utils/loggers.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLogging();
  Loggers.mainLogger.info('Passwd initialized');

  if (Platform.isAndroid || Platform.isIOS) {
    initializeLocator();
  } else {
    await setupDesktopWindow();
    initializeLocator('desktop');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      TouchBarPlugin.registerWith(); // hack

      setTouchBar(
        TouchBar(
          children: [
            TouchBarLabel(
              'Passwd.',
              textColor: primaryColor,
            ),
          ],
        ),
      );
    }

    return AsyncReduxProvider<AppState>.value(
      value: Store<AppState>(
        initialState: AppState(
          entries: Entries(entries: []),
          isSyncing: false,
          autofillLaunch: false,
          isLoggedIn: false,
        ),
      ),
      child: EzLocalizationBuilder(
        delegate: EzLocalizationDelegate(
          supportedLocales: [
            Locale('en'),
            Locale('hi'),
            Locale('fr'),
            Locale('nl'),
            Locale('pl'),
          ],
        ),
        builder: (context, localizationDelegate) => MaterialApp(
          title: 'Passwd',
          localizationsDelegates: localizationDelegate.localizationDelegates,
          supportedLocales: localizationDelegate.supportedLocales,
          localeResolutionCallback:
              localizationDelegate.localeResolutionCallback,
          theme: ThemeData.dark().copyWith(
            primaryColor: primaryColor,
            accentColor: primaryColor,
            iconTheme: IconThemeData(
              color: ThemeData.dark().iconTheme.color,
            ),
            textTheme: textTheme,
            visualDensity: VisualDensity.standard,
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
                      backgroundColor: canvasColor,
                      unselectedIconTheme: IconThemeData(
                        color: Colors.white.withOpacity(0.92),
                      ),
                      showUnselectedLabels: false,
                      elevation: 4,
                    ),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: primaryColor,
              selectionColor: primaryColor.withOpacity(0.4),
              selectionHandleColor: primaryColor,
            ),
            buttonColor: primaryColor,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.hovered) ||
                      states.contains(MaterialState.focused) ||
                      states.contains(MaterialState.pressed)) {
                    return primaryColorHovered;
                  }

                  return primaryColor;
                }),
                overlayColor: MaterialStateProperty.all(
                  primaryColor.withOpacity(0.24),
                ),
              ),
            ),
            splashColor: primaryColor.withOpacity(0.24),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                overlayColor: MaterialStateProperty.all(
                  primaryColor.withOpacity(0.24),
                ),
              ),
            ),
            buttonTheme: ButtonThemeData(
              buttonColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              highlightColor: primaryColor.withOpacity(0.24),
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
            navigationRailTheme: NavigationRailThemeData(
              backgroundColor: Colors.white.withOpacity(0.025),
              unselectedIconTheme: IconThemeData(
                color: Colors.white.withOpacity(0.92),
              ),
              selectedIconTheme: IconThemeData(
                color: primaryColor,
              ),
              unselectedLabelTextStyle: TextStyle(
                color: Colors.white.withOpacity(0.92),
              ),
              selectedLabelTextStyle: TextStyle(
                color: primaryColor,
              ),
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

            if (Platform.isMacOS) {
              final mediaQueryData = MediaQueryData.fromWindow(
                WidgetsBinding.instance.window,
              );

              final paddedMediaQueryData = mediaQueryData.copyWith(
                padding: mediaQueryData.padding.copyWith(
                  top: 20,
                ),
              );

              return MediaQuery(
                data: paddedMediaQueryData,
                child: child,
              );
            }

            return child;
          },
          debugShowCheckedModeBanner: false,
          // home: InitScreen(),
          routes: {
            '/': (context) => InitScreen(),
            '/autofill': (context) => InitScreen(
                  dispatchAutofill: true,
                ),
          },
        ),
      ),
    );
  }
}
