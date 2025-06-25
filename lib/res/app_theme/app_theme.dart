// import 'package:flutter/material.dart';

// // ------------------- LIGHT MODE ------------------------
// final ThemeData lightMode = ThemeData(
//   brightness: Brightness.light,
//   useMaterial3: true,

//   // Background color of Scaffold (e.g. main screen)
//   scaffoldBackgroundColor: Color(0xFFFFFFFF),

//   colorScheme: ColorScheme.light(
//     primary: Color(0xFFF59EC1),

//     // ^ Used for AppBar background, ElevatedButton background, etc.
//     onPrimary: Colors.black,

//     // ^ Text/icons on top of primary color (like on AppBar title or button text)
//     secondary: Color.fromARGB(200, 74, 171, 15),

//     // ^ Used for highlights, FloatingActionButton, toggles
//     onSecondary: Color(0xFFF2F4FF),

//     // ^ Text/icons on secondary color background
//     surface: Color.fromARGB(255, 0, 0, 0),

//     // ^ Used as background for Cards, Dialogs, Menus
//     // surfaceContainer: Color(0xfffaf6e9),
//     surfaceContainer: const Color.fromARGB(255, 238, 243, 238),

//     // ^ Custom key: used in your app manually for Cards/Containers
//     onSurface: Colors.black,

//     // ^ Text/icons on surface
//     error: Colors.red.shade700,
//     onError: Colors.white,
//   ),
// );

// // ------------------- DARK MODE ------------------------
// final ThemeData darkMode = ThemeData(
//   brightness: Brightness.dark,
//   useMaterial3: true,

//   // Background color of Scaffold
//   scaffoldBackgroundColor: Color(0xFF1A1A1A),

//   colorScheme: ColorScheme.dark(
//     primary: Color(0xFFF59EC1),

//     // ^ Used for AppBar background, ElevatedButton background, etc.
//     onPrimary: Colors.black,

//     // ^ Text/icons on top of primary color
//     secondary: Color.fromARGB(255, 137, 137, 137),

//     // ^ Used for FloatingActionButton or accent elements
//     onSecondary: Color.fromARGB(255, 53, 53, 53),
//     surface: Color(0xFFFFFFFF),

//     // ^ Card/Container background
//     onSurface: Colors.white,
//     error: Colors.red.shade400,
//     onError: Colors.black,
//   ),
// );

import 'package:flutter/material.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';

class AppThemes {
  static final light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFF59EC1),
    scaffoldBackgroundColor: AppColors.lightBackground,
    useMaterial3: true,
    colorScheme: ColorScheme.light(onSecondary: AppColors.lightclipRRback),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.lightTextcolor,
      foregroundColor: AppColors.lightText,
      surfaceTintColor: Colors.transparent,
    ),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.lightPrimary,
      selectionColor: AppColors.lightPrimary.withAlpha(90),
      selectionHandleColor: AppColors.lightPrimary, // <-- Handle color
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.lightText, fontSize: 30),
      titleLarge: TextStyle(color: AppColors.lightTextcolor, fontSize: 25),
      titleMedium: TextStyle(color: AppColors.lightTextcolor, fontSize: 22),
      titleSmall: TextStyle(color: AppColors.lightText, fontSize: 16),
      headlineLarge: TextStyle(
        color: AppColors.lightText,
        fontSize: 25,
        // fontWeight: FontWeight.bold, // Uncomment if needed
      ),
      headlineMedium: TextStyle(color: AppColors.lightText, fontSize: 22),
      headlineSmall: TextStyle(color: AppColors.lightText, fontSize: 16),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPrimary,
        foregroundColor: AppColors.lightTextcolor,
        fixedSize: const Size(double.infinity, 60),
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.lightPrimary,
        textStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightPrimary, width: 2),
      ),
    ),

    cardTheme: CardTheme(
      color: Colors.white,
      margin: EdgeInsets.all(10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
    iconTheme: IconThemeData(color: AppColors.lightText),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.lightPrimary,
      contentTextStyle: TextStyle(color: Colors.white),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.lightPrimary,
      unselectedItemColor: Colors.grey,
      backgroundColor: AppColors.accent.withAlpha(100),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.lightPrimary,
      foregroundColor: Colors.white,
    ),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    // scaffoldBackgroundColor: Colors.black,
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      onSecondary: const Color.fromARGB(255, 50, 50, 50),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.lightText,
      foregroundColor: AppColors.darkText,
      surfaceTintColor: Colors.transparent,
    ),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.lightPrimary,
      selectionColor: AppColors.lightPrimary.withAlpha(90),
      selectionHandleColor: AppColors.lightPrimary, // <-- Handle color
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkText, fontSize: 30),
      titleLarge: TextStyle(color: AppColors.darkTextcolor, fontSize: 25),
      titleMedium: TextStyle(color: AppColors.darkTextcolor, fontSize: 22),
      titleSmall: TextStyle(color: AppColors.lightTextcolor, fontSize: 16),
      headlineMedium: TextStyle(
        color: AppColors.lightTextcolor,
        fontSize: 22,
        // fontWeight: FontWeight.bold, // Uncomment if needed
      ),
      headlineLarge: TextStyle(
        color: AppColors.lightTextcolor,
        fontSize: 25,
        // fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(color: AppColors.lightTextcolor, fontSize: 16),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPrimary,
        foregroundColor: Colors.white,
        fixedSize: const Size(double.infinity, 60),
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.darkPrimary,
        textStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade800,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightPrimary, width: 2),
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.grey.shade900,
      margin: EdgeInsets.all(10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
    iconTheme: IconThemeData(color: AppColors.lightTextcolor),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.lightPrimary,
      contentTextStyle: TextStyle(color: Colors.white),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.lightPrimary,
      unselectedItemColor: Colors.grey,
      backgroundColor: AppColors.lightText.withAlpha(100),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: Colors.white,
    ),
  );
}
