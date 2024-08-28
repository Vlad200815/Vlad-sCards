import 'package:flutter/material.dart';

const primaryColor = Colors.blue;

// final themeData = ThemeData(
//   useMaterial3: true,
//   colorScheme: ColorScheme.fromSeed(
//     seedColor: const Color.fromARGB(255, 0, 94, 255),
//     brightness: Brightness.light,
//     surface: const Color.fromARGB(255, 244, 250, 253),
//     onSecondary: Colors.yellow[700],
//     error: Colors.red,
//     inversePrimary: const Color.fromARGB(255, 95, 220, 101),
//     scrim: const Color.fromARGB(255, 224, 243, 255),
//     onPrimaryFixed: Colors.grey[350],
//   ),
// );

//LIGHT THEME
final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  textTheme: textTheme,
  scaffoldBackgroundColor: const Color.fromARGB(255, 244, 250, 253),
  dividerTheme: DividerThemeData(
    color: Colors.grey.withOpacity(0.1),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    primary: primaryColor,
    onPrimary: const Color.fromARGB(255, 195, 229, 255),
    onPrimaryFixed: Colors.white,
    inversePrimary: Colors.black,
    onSecondary: const Color.fromARGB(255, 200, 234, 255),
    onTertiary: Colors.white,
    brightness: Brightness.light,
  ),
);

//DARK THEME
final darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  textTheme: textTheme,
  scaffoldBackgroundColor: Colors.black,
  dividerTheme: DividerThemeData(
    color: Colors.grey.withOpacity(0.1),
  ),
  colorScheme: ColorScheme.fromSeed(
    primary: primaryColor,
    seedColor: primaryColor,
    onPrimary: const Color.fromARGB(255, 38, 41, 43),
    onPrimaryFixed: Colors.black,
    inversePrimary: Colors.white,
    onSecondary: const Color.fromARGB(255, 38, 41, 43),
    onTertiary: const Color.fromARGB(255, 38, 41, 43),
    brightness: Brightness.dark,
  ),
);

//TEXT THEME
const textTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
  ),
  bodySmall: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
  bodyLarge: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  ),
  bodyMedium: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  ),
  titleLarge: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
  ),
);