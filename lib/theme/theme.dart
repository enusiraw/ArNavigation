import 'package:ar_navigation/includes/colors.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  fontFamily: "Agbalumo",
  hintColor: Colors.black54,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    bodySmall: TextStyle(color: Colors.black),
    labelLarge: TextStyle(color: Colors.black),
    labelMedium: TextStyle(color: Colors.black),
    labelSmall: TextStyle(color: Colors.black),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 240, 233, 233),
  appBarTheme: AppBarTheme(
    backgroundColor: MyColors.secondaryColor,
    titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: MyColors.primaryColorBg,
    ),
  ),
  colorScheme: ColorScheme.light(
    primary: MyColors.primaryColorBg,
    onPrimary: Colors.white,
    secondary: MyColors.secondaryColor,
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
  ),
);

final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.blue,
  fontFamily: "Agbalumo",
  hintColor: Colors.white54,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    labelLarge: TextStyle(color: Colors.white),
    labelMedium: TextStyle(color: Colors.white),
    labelSmall: TextStyle(color: Colors.white),
  ),
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blueGrey,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blueGrey,
    ),
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.blueGrey,
    onPrimary: Colors.white,
    secondary: MyColors.secondaryColor,
    onSecondary: Colors.white,
    surface: Colors.black,
    onSurface: Colors.white,
  ),
);
