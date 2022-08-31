import 'package:flutter/material.dart';

abstract class AppThemes {

  static ThemeData defaultTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      color: Color.fromARGB(255, 104, 167, 173),
    ),
    cardColor: const Color.fromARGB(255, 229, 203, 159),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontFamily: 'OpenSans', 
        fontWeight: FontWeight.w400,
        fontSize: 23,
      ),
      labelMedium: const TextStyle(
        fontFamily: 'OpenSans', 
        fontSize: 16,
      ),
    ).apply(
      bodyColor: Colors.black,
    )
  );
      
}