import 'package:flutter/material.dart';

const COLOR_PRIMARY = Colors.purple;
const COLOR_ACCENT = Colors.purple;

class MyThemes {
  static final lightTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.purple,
      primaryColor: COLOR_PRIMARY,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: COLOR_ACCENT),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0)),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
              backgroundColor: MaterialStateProperty.all<Color>(COLOR_ACCENT))),
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.1)),
      drawerTheme: DrawerThemeData(
        backgroundColor: COLOR_ACCENT,
       // scrimColor: COLOR_ACCENT,
      )
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    accentColor: Colors.white,
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(Colors.grey),
      thumbColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0))),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            overlayColor: MaterialStateProperty.all<Color>(Colors.black26))),
  );
}
