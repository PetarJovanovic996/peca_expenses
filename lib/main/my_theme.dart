import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
  primaryColor: const Color.fromARGB(255, 92, 80, 101),

  scaffoldBackgroundColor: const Color.fromARGB(255, 227, 214, 218),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black87, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.black54, fontSize: 14),
    titleLarge: TextStyle(
        color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color.fromARGB(255, 43, 5, 18),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),

  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 43, 5, 18),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 43, 5, 18),
    foregroundColor: Colors.white,
  ),

  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color.fromARGB(255, 43, 5, 18),
  ),

  // **Input Fields (TextFormField)**
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color.fromARGB(255, 247, 243, 243),
    hintStyle: const TextStyle(color: Color.fromARGB(255, 5, 5, 5)),
    labelStyle: const TextStyle(color: Color.fromARGB(255, 11, 11, 11)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide:
          const BorderSide(color: Color.fromARGB(255, 4, 4, 4), width: 1.5),
    ),
  ),

  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color.fromARGB(255, 157, 95, 95),
    contentTextStyle: TextStyle(color: Color.fromARGB(255, 198, 130, 130)),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 43, 5, 18),
    selectedItemColor: Color.fromARGB(255, 247, 246, 246),
    unselectedItemColor: Colors.white,
  ),
);
