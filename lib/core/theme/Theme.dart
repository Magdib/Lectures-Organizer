import 'package:flutter/material.dart';
import 'package:unversityapp/core/Constant/AppColors.dart';

class Themes {
  static const String fontFamily = "Tajawal";

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    primaryColor: AppColors.primaryColor,
    dialogTheme: const DialogTheme(
      elevation: 0,
    ),
    colorScheme: const ColorScheme.light(
        onPrimary: Color.fromARGB(255, 4, 42, 71),
        onSecondary: AppColors.primaryColor,
        onPrimaryContainer: Color.fromARGB(255, 10, 74, 123),
        onSecondaryContainer: Color.fromARGB(255, 13, 99, 165)),
    secondaryHeaderColor: AppColors.green,
    primaryColorDark: AppColors.cyan,
    primaryColorLight: AppColors.black,
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: AppColors.deepblue),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      colorScheme: const ColorScheme.light(
          background: AppColors.deepblue, onBackground: AppColors.white),
      disabledColor: AppColors.grey,
    ),
    appBarTheme: const AppBarTheme(scrolledUnderElevation: 0),
    popupMenuTheme: const PopupMenuThemeData(elevation: 0),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.deepblue),
    sliderTheme: const SliderThemeData(
        thumbColor: AppColors.deepblue, activeTrackColor: AppColors.deepblue),
    dialogBackgroundColor: AppColors.backgroundColor,
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: AppColors.deepblue,
          fontFamily: fontFamily),
      headline2: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: AppColors.black,
          fontFamily: fontFamily),
      headline3: TextStyle(
          fontSize: 20,
          color: AppColors.lightgrey,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily),
      headline4: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 35,
          color: AppColors.deepblue,
          fontFamily: fontFamily),
      headline6: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: AppColors.blue,
          fontFamily: fontFamily),
      bodyText1: TextStyle(
          fontSize: 15,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily),
      bodyText2: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: AppColors.grey,
          fontFamily: fontFamily),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.black,
    primaryColor: AppColors.cyan,
    secondaryHeaderColor: AppColors.green,
    primaryColorDark: AppColors.cyan,
    primaryColorLight: AppColors.white,
    colorScheme: const ColorScheme.light(
        onPrimary: Color.fromARGB(255, 10, 144, 144),
        onSecondary: Color.fromARGB(255, 20, 168, 168),
        onPrimaryContainer: Color.fromARGB(255, 23, 199, 199),
        onSecondaryContainer: Color.fromARGB(255, 4, 239, 239)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.veryDeepCyan),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: AppColors.cyan)),
      colorScheme: const ColorScheme.light(
          background: AppColors.black, onBackground: AppColors.black),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.veryDeepCyan),
    sliderTheme: const SliderThemeData(
      thumbColor: AppColors.cyan,
      activeTrackColor: AppColors.cyan,
    ),
    appBarTheme: const AppBarTheme(scrolledUnderElevation: 0),
    dialogTheme: const DialogTheme(
      elevation: 0,
    ),
    popupMenuTheme: const PopupMenuThemeData(elevation: 0),
    dialogBackgroundColor: AppColors.lightBlack,
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: AppColors.cyan,
          fontFamily: fontFamily),
      headline2: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: AppColors.white,
          fontFamily: fontFamily),
      headline3: TextStyle(
          fontSize: 20,
          color: AppColors.lightgrey,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily),
      headline4: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 35,
          color: AppColors.cyan,
          fontFamily: fontFamily),
      headline5: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: AppColors.white,
          fontFamily: fontFamily),
      headline6: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: AppColors.cyan,
          fontFamily: fontFamily),
      bodyText1: TextStyle(
          fontSize: 15,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily),
      bodyText2: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: AppColors.white,
          fontFamily: fontFamily),
    ),
  );
}
