import 'package:flutter/material.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';

class DarkTheme {
  static border([Color color = AppPallete.lightBlue]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: color,
          width: 2,
        ),
      );

  static final darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,

    // Color Scheme
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: AppPallete.blue,
    ),
    canvasColor: AppPallete.backgroundColor,
    primaryColor: AppPallete.white,
    highlightColor: AppPallete.highLightBlue,
    shadowColor: AppPallete.onBlackBackgroundColor,

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
      surfaceTintColor: AppPallete.backgroundColor,
      foregroundColor: AppPallete.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppPallete.white,
        fontSize: 20,
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
      enabledBorder: border(AppPallete.grey),
      focusedBorder: border(),
      errorBorder: border(AppPallete.red),
      errorStyle: const TextStyle(color: AppPallete.red),
      focusedErrorBorder: border(AppPallete.red),
      border: border(),
    ),

    // Texts
    primaryTextTheme: const TextTheme(
      headlineLarge: TextStyle(color: AppPallete.white),
      headlineMedium: TextStyle(color: AppPallete.white),
      headlineSmall: TextStyle(color: AppPallete.white),
      bodyLarge: TextStyle(color: AppPallete.white),
      bodyMedium: TextStyle(color: AppPallete.white),
      bodySmall: TextStyle(color: AppPallete.white),
      displayLarge: TextStyle(color: AppPallete.white),
      displayMedium: TextStyle(color: AppPallete.white),
      displaySmall: TextStyle(color: AppPallete.white),
      labelLarge: TextStyle(color: AppPallete.white),
      labelMedium: TextStyle(color: AppPallete.white),
      labelSmall: TextStyle(color: AppPallete.white),
      titleLarge: TextStyle(color: AppPallete.white),
      titleMedium: TextStyle(color: AppPallete.white),
      titleSmall: TextStyle(color: AppPallete.white),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: AppPallete.white),
      headlineMedium: TextStyle(color: AppPallete.white),
      headlineSmall: TextStyle(color: AppPallete.white),
      bodyLarge: TextStyle(color: AppPallete.white),
      bodyMedium: TextStyle(color: AppPallete.white),
      bodySmall: TextStyle(color: AppPallete.white),
      displayLarge: TextStyle(color: AppPallete.white),
      displayMedium: TextStyle(color: AppPallete.white),
      displaySmall: TextStyle(color: AppPallete.white),
      labelLarge: TextStyle(color: AppPallete.white),
      labelMedium: TextStyle(color: AppPallete.white),
      labelSmall: TextStyle(color: AppPallete.white),
      titleLarge: TextStyle(color: AppPallete.white),
      titleMedium: TextStyle(color: AppPallete.white),
      titleSmall: TextStyle(color: AppPallete.white),
    ),
    // Text Selection
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: AppPallete.lightBlue),

    // Text Button
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        alignment: Alignment.center,
        foregroundColor: WidgetStatePropertyAll(AppPallete.white),
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
      unselectedItemColor: AppPallete.white,
      unselectedLabelStyle: TextStyle(color: AppPallete.white),
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
      backgroundColor: AppPallete.backgroundColor,
      type: BottomNavigationBarType.fixed,
    ),

    // Icon Button
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppPallete.white),
      ),
    ),

    // Card
    cardTheme: const CardTheme(elevation: 1),

    // Tab Bar
    tabBarTheme: const TabBarTheme(
      indicatorColor: AppPallete.lightBlue,
      unselectedLabelColor: AppPallete.white,
      labelColor: AppPallete.lightBlue,
      dividerColor: AppPallete.transparent,
      tabAlignment: TabAlignment.center,
    ),
    //ListTile
    listTileTheme: const ListTileThemeData(
      iconColor: AppPallete.lightBlue,
      titleTextStyle: TextStyle(fontSize: 12, color: AppPallete.grey),
      subtitleTextStyle: TextStyle(fontSize: 14, color: AppPallete.white),
    ),

    // Icon
    iconTheme: const IconThemeData(color: AppPallete.lightBlue),

    //Switch
    switchTheme: SwitchThemeData(
      trackOutlineColor:
          const WidgetStatePropertyAll(AppPallete.backgroundColor),
      thumbColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return AppPallete.lightBlue;
          } else {
            return AppPallete.black;
          }
        },
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return AppPallete.blueAccent;
          } else {
            return AppPallete.grey;
          }
        },
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),

    // Pop Up Menu Button
    popupMenuTheme: const PopupMenuThemeData(
      surfaceTintColor: AppPallete.backgroundColor,
      iconColor: AppPallete.white,
      color: AppPallete.backgroundColor,
      shadowColor: AppPallete.lightBlue,
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(color: AppPallete.white),
      ),
    ),

    // Dialog
    dialogTheme: const DialogTheme(
      backgroundColor: AppPallete.backgroundColor,
    ),
    //
  );
}
