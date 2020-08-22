import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passwd/constants/colors.dart';
import 'package:supercharged/supercharged.dart';

TextTheme textTheme = TextTheme(
  headline1: GoogleFonts.montserrat(
    fontSize: 96,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  ),
  headline2: GoogleFonts.montserrat(
    fontSize: 60,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  ),
  headline3: GoogleFonts.montserrat(
    fontSize: 48,
    fontWeight: FontWeight.w400,
  ),
  headline4: GoogleFonts.montserrat(
    fontSize: 34,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  headline5: GoogleFonts.montserrat(
    fontSize: 24,
    fontWeight: FontWeight.w400,
  ),
  headline6: GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  subtitle1: GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  subtitle2: GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyText1: GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyText2: GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  button: GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  caption: GoogleFonts.montserrat(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  overline: GoogleFonts.montserrat(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
);

PageTransitionsTheme pageTransitionsTheme = PageTransitionsTheme(
  builders: <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: SharedAxisPageTransitionsBuilder(
      transitionType: SharedAxisTransitionType.scaled,
    ),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  },
);

AppBarTheme appBarTheme = AppBarTheme(
  color: Colors.transparent,
  elevation: 0,
  centerTitle: true,
);

SnackBarThemeData snackBarTheme = SnackBarThemeData(
  behavior: SnackBarBehavior.floating,
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: primaryColor,
  accentColor: primaryColor,
  iconTheme: IconThemeData(
    color: ThemeData.dark().iconTheme.color,
  ),
  textTheme: textTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
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
  bottomNavigationBarTheme: ThemeData.dark().bottomNavigationBarTheme.copyWith(
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
  buttonColor: primaryColor,
  dialogTheme: DialogTheme(
    backgroundColor: "#181818".toColor(),
  ),
  snackBarTheme: snackBarTheme,
);

ThemeData lightTheme = ThemeData(
  primaryColor: primaryColorLight,
  accentColor: primaryColorLight,
  iconTheme: IconThemeData(
    color: "#181818".toColor(),
  ),
  textTheme: textTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  pageTransitionsTheme: pageTransitionsTheme,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primaryColorLight,
  ),
  appBarTheme: appBarTheme.copyWith(
    brightness: Brightness.light,
    iconTheme: IconThemeData(
      color: "#181818".toColor(),
    ),
  ),
  canvasColor: canvasColorLight,
  scaffoldBackgroundColor: canvasColorLight,
  bottomNavigationBarTheme: ThemeData.dark().bottomNavigationBarTheme.copyWith(
        backgroundColor: Colors.white,
        elevation: 4,
      ),
  cursorColor: primaryColorLight,
  buttonTheme: ButtonThemeData(
    buttonColor: primaryColorLight,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    hoverColor: primaryColorHovered,
    highlightColor: primaryColorHovered,
  ),
  backgroundColor: canvasColorLight,
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      fontSize: 14,
      letterSpacing: 1.5,
    ),
  ),
  buttonColor: primaryColorLight,
  dialogTheme: DialogTheme(
    backgroundColor: "#f4f4f4".toColor(),
  ),
  snackBarTheme: snackBarTheme,
);
