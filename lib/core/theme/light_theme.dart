import 'package:flutter/material.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';

class LightTheme {
  static border([Color color = AppPallete.lightBlue]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: color,
          width: 2,
        ),
      );

  static final lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppPallete.white,

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.white,
      surfaceTintColor: AppPallete.white,
      foregroundColor: AppPallete.backgroundColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppPallete.black,
      ),
    ),

    // ElevatedButton
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        enableFeedback: true,
        shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)))),
        minimumSize: WidgetStatePropertyAll(Size(1000, 55)),
        maximumSize: WidgetStatePropertyAll(Size(1000, 55)),
        foregroundColor: WidgetStatePropertyAll(AppPallete.white),
        backgroundColor: WidgetStatePropertyAll(AppPallete.lightBlue),
        alignment: Alignment.center,
      ),
    ),

    // TextFields
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(20),
      enabledBorder: border(),
      focusedBorder: border(AppPallete.lightBlue),
      errorBorder: border(AppPallete.red),
      errorStyle: const TextStyle(color: AppPallete.red),
      focusedErrorBorder: border(AppPallete.red),
      border: border(),
    ),

    // Texts
    primaryTextTheme: const TextTheme(
      headlineLarge: TextStyle(color: AppPallete.black),
      headlineMedium: TextStyle(color: AppPallete.black),
      headlineSmall: TextStyle(color: AppPallete.black),
      bodyLarge: TextStyle(color: AppPallete.black),
      bodyMedium: TextStyle(color: AppPallete.black),
      bodySmall: TextStyle(color: AppPallete.black),
      displayLarge: TextStyle(color: AppPallete.black),
      displayMedium: TextStyle(color: AppPallete.black),
      displaySmall: TextStyle(color: AppPallete.black),
      labelLarge: TextStyle(color: AppPallete.black),
      labelMedium: TextStyle(color: AppPallete.black),
      labelSmall: TextStyle(color: AppPallete.black),
      titleLarge: TextStyle(color: AppPallete.black),
      titleMedium: TextStyle(color: AppPallete.black),
      titleSmall: TextStyle(color: AppPallete.black),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: AppPallete.black),
      headlineMedium: TextStyle(color: AppPallete.black),
      headlineSmall: TextStyle(color: AppPallete.black),
      bodyLarge: TextStyle(color: AppPallete.black),
      bodyMedium: TextStyle(color: AppPallete.black),
      bodySmall: TextStyle(color: AppPallete.black),
      displayLarge: TextStyle(color: AppPallete.black),
      displayMedium: TextStyle(color: AppPallete.black),
      displaySmall: TextStyle(color: AppPallete.black),
      labelLarge: TextStyle(color: AppPallete.black),
      labelMedium: TextStyle(color: AppPallete.black),
      labelSmall: TextStyle(color: AppPallete.black),
      titleLarge: TextStyle(color: AppPallete.black),
      titleMedium: TextStyle(color: AppPallete.black),
      titleSmall: TextStyle(color: AppPallete.black),
    ),

    // Text Selection
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: AppPallete.lightBlue),

    // Text Button
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        alignment: Alignment.center,
        foregroundColor: WidgetStatePropertyAll(AppPallete.black),
      ),
    ),

    // FloatingActionButton
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppPallete.lightBlue,
      foregroundColor: AppPallete.white,
      enableFeedback: true,
    ),

    // Chip
    chipTheme: const ChipThemeData(
      labelStyle: TextStyle(color: AppPallete.lightBlue),
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      enableFeedback: true,
      elevation: 0,
      selectedItemColor: AppPallete.lightBlue,
      selectedLabelStyle: TextStyle(color: AppPallete.lightBlue),
      unselectedItemColor: AppPallete.backgroundColor,
      unselectedLabelStyle: TextStyle(color: AppPallete.backgroundColor),
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
      backgroundColor: AppPallete.white,
      type: BottomNavigationBarType.fixed,
    ),

    // Icon Button
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppPallete.white),
        backgroundColor: WidgetStatePropertyAll(AppPallete.lightBlue),
      ),
    ),

    // Card
    cardTheme: const CardTheme(elevation: 1),

    // Tab Bar
    tabBarTheme: const TabBarTheme(
      indicatorColor: AppPallete.transpartent,
      unselectedLabelColor: AppPallete.black,
      labelColor: AppPallete.lightBlue,
    ),

    //
  );
}
