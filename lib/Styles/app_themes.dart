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
      labelSmall: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 14,
      ),
      labelMedium: TextStyle(
        fontFamily: 'OpenSans', 
        fontSize: 16,
      ),
      displayMedium: TextStyle(
        fontFamily: 'OpenSans', 
        fontSize: 23,
        fontStyle: FontStyle.italic
      )
    ).apply(
      bodyColor: Colors.black,
    ),
  );

  static ButtonStyle largeFormButton = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 229, 203, 159),),
      
    );
      
}