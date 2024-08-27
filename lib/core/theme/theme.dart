import 'package:flutter/material.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';

class AppTheme {
  static border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: color,
          width: 2,
        ),
      );

  static final darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppPallete.scaffoldBackgroundColor,
    // AppBar
    appBarTheme: const AppBarTheme(
        backgroundColor: AppPallete.scaffoldBackgroundColor,
        surfaceTintColor: AppPallete.scaffoldBackgroundColor,
        foregroundColor: AppPallete.appBarForegroundColor,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )),

    // TextFields
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(20),
      enabledBorder: border(),
      focusedBorder: border(AppPallete.borderFocusColor),
      errorBorder: border(AppPallete.errorColor),
      errorStyle: const TextStyle(color: AppPallete.errorColor),
      focusedErrorBorder: border(AppPallete.errorColor),
      border: border(),
    ),

    // Buttons
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
          enableFeedback: true,
          shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)))),
          minimumSize: WidgetStatePropertyAll(Size(1000, 55)),
          maximumSize: WidgetStatePropertyAll(Size(1000, 55)),
          foregroundColor:
              WidgetStatePropertyAll(AppPallete.appBarForegroundColor),
          backgroundColor:
              WidgetStatePropertyAll(AppPallete.elevatedButtonBackgroundColor),
          alignment: Alignment.center,
          textStyle: WidgetStatePropertyAll(
              TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
    ),

    // Texts
    primaryTextTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40,
          color: AppPallete.elevatedButtonBackgroundColor),
      headlineMedium: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: AppPallete.elevatedButtonBackgroundColor),
      bodyLarge: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18, color: AppPallete.white),
      bodyMedium: TextStyle(
          fontWeight: FontWeight.normal, fontSize: 16, color: AppPallete.white),
      bodySmall: TextStyle(
          fontWeight: FontWeight.normal, fontSize: 12, color: AppPallete.white),
      displaySmall: TextStyle(
          fontWeight: FontWeight.normal, fontSize: 12, color: AppPallete.grey),
    ),

    // SnackBars
    snackBarTheme: const SnackBarThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      dismissDirection: DismissDirection.down,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      actionOverflowThreshold: 0,
    ).copyWith(dismissDirection: DismissDirection.down),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppPallete.scaffoldBackgroundColor,
      selectedItemColor: AppPallete.bottomNavigationBarSelectedColor,
      unselectedItemColor: AppPallete.white,
      elevation: 0,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(fontSize: 12),
      unselectedLabelStyle: TextStyle(fontSize: 10),
      selectedIconTheme: IconThemeData(size: 25),
      unselectedIconTheme: IconThemeData(size: 22),
      enableFeedback: true,
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
      type: BottomNavigationBarType.fixed,
    ),

    //Card
    cardTheme: const CardTheme(
        surfaceTintColor: AppPallete.white,
        color: AppPallete.cardBackgroundColor),

    //ListTile
    listTileTheme: const ListTileThemeData(
      iconColor: AppPallete.elevatedButtonBackgroundColor,
      titleTextStyle: TextStyle(fontSize: 12, color: AppPallete.borderColor),
      subtitleTextStyle: TextStyle(fontSize: 14, color: AppPallete.white),
    ),

    //TabBar
    tabBarTheme: const TabBarTheme(
      // labelPadding: EdgeInsets.only(right: 50),
      indicatorColor: AppPallete.elevatedButtonBackgroundColor,
      labelColor: AppPallete.elevatedButtonBackgroundColor,
      dividerColor: AppPallete.transpartent,
      tabAlignment: TabAlignment.center,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              width: 1.0, color: AppPallete.elevatedButtonBackgroundColor),
        ),
      ),
    ),

    //Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return AppPallete.elevatedButtonBackgroundColor;
          } else {
            return AppPallete.appBarForegroundColor;
          }
        },
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return AppPallete.switchInActiveTrackColor;
          } else {
            return null;
          }
        },
      ),
    ),

    //Chip
    chipTheme: const ChipThemeData(
        labelStyle: TextStyle(
      color: AppPallete.elevatedButtonBackgroundColor,
    )),

    //FloatingActionButton
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppPallete.elevatedButtonBackgroundColor,
      enableFeedback: true,
    ),
  );
}
