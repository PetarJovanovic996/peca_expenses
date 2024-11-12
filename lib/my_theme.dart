import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
  // **Primarna boja aplikacije (Primary Color)**
  primaryColor:
      const Color.fromARGB(255, 92, 80, 101), // Svetlo plava kao osnovna boja

  // **Pozadina aplikacije (Scaffold Background)**
  scaffoldBackgroundColor: Color.fromARGB(
      255, 227, 214, 218), // Bela pozadina daje čist i osvežavajući izgled

  // **Tekst (Text Theme)**
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
        color: Colors.black87,
        fontSize: 16), // Crni tekst za osnovne informacije
    bodyMedium: TextStyle(
        color: Colors.black54,
        fontSize: 14), // Sivi tekst za sekundarne informacije
    titleLarge: TextStyle(
        color: Colors.black54,
        fontSize: 20,
        fontWeight: FontWeight.bold), // Naglašeni naslovi
  ), // Svetlo narandžasta boja za akcente (dugmadi, linkove)

  // **Dugmadi (Elevated Button)**
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor:
          const Color.fromARGB(255, 43, 5, 18), // Bela boja za tekst na dugmetu
      padding: const EdgeInsets.symmetric(
          vertical: 12, horizontal: 20), // Padding za dugme
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Zaobljeni kutovi
      ),
    ),
  ),

  // **Ikone (Icon Theme)**
  iconTheme: const IconThemeData(
    color: const Color.fromARGB(
        255, 43, 5, 18), // Tamno ljubičaste ikone koje dodaju eleganciju
  ),

  // **AppBar Tema (Bar sa Navigacijom)**
  appBarTheme: const AppBarTheme(
    backgroundColor:
        Color.fromARGB(255, 43, 5, 18), // Svetlo zelena boja za AppBar
    foregroundColor: Colors.white, // Bela boja za tekst i ikone u AppBar-u
  ),

  // **BottomAppBar Tema**
  bottomAppBarTheme: BottomAppBarTheme(
    color: Color.fromARGB(255, 43, 5, 18), // Svetlo zelena boja za BottomAppBar
  ),

  // **Input Fields (TextFormField)**
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color.fromARGB(
        255, 247, 243, 243), // Svetlo plavi ton za pozadinu inputa
    hintStyle:
        TextStyle(color: const Color.fromARGB(255, 5, 5, 5)), // Sivi hint tekst
    labelStyle: TextStyle(
        color:
            const Color.fromARGB(255, 11, 11, 11)), // Svetlo plava boja labela
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
          color: const Color.fromARGB(255, 4, 4, 4), width: 1.5), // Border boja
    ),
  ),

  // **Snackbar (Za obaveštenja)**
  snackBarTheme: SnackBarThemeData(
    backgroundColor:
        const Color.fromARGB(255, 157, 95, 95), // Roza pozadina za SnackBar
    contentTextStyle: TextStyle(
        color: const Color.fromARGB(
            255, 198, 130, 130)), // Bela boja teksta u Snackbaru
  ),

  // **Bottom Navigation Bar Tema**
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor:
        Color.fromARGB(255, 43, 5, 18), // Svetlo zelena boja za BottomAppBar
    selectedItemColor: const Color.fromARGB(
        255, 247, 246, 246), // Akcentna roza boja za selektovane stavke
    unselectedItemColor: Colors.white, // Bela boja za neselektovane stavke
  ),
);
