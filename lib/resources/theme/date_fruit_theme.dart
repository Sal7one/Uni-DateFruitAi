import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:datefruitnew/resources/colors/Colors.dart';
import 'package:datefruitnew/resources/string_constants.dart';

class CustomAppTheme with ChangeNotifier {
  static ThemeData get globalAppTheme {
    return ThemeData(
      fontFamily: 'open-sans',
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: ApplicationColors.bottomNavItem,
          backgroundColor: ApplicationColors.bottomNavBackground),
      textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 20),
          bodyMedium: TextStyle(color: LightColors.white),
          headlineSmall: TextStyle(color: LightColors.white)),
    );
  }

  static ThemeData get lightTheme {
    return globalAppTheme.copyWith(
      primaryColor: LightColors.primary,
      scaffoldBackgroundColor: LightColors.scaffold,
      appBarTheme: lightAppBarTheme(),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: LightColors.bottomNavItem,
          backgroundColor: LightColors.bottomNavBackground,
          unselectedItemColor: LightColors.bottomNavItemNotSelected),
      iconTheme: const IconThemeData(color: LightColors.black),
      textTheme: globalAppTheme.textTheme.copyWith(
        headlineSmall: globalAppTheme.textTheme.headlineSmall
            ?.copyWith(color: LightColors.black),
        bodyLarge: globalAppTheme.textTheme.bodyLarge
            ?.copyWith(color: LightColors.black),
      ),
    );
  }

  static ThemeData get darkTheme {
    return globalAppTheme.copyWith(
      primaryColor: DarkColors.primary,
      scaffoldBackgroundColor: DarkColors.scaffold,
      appBarTheme: darkAppBarTheme(),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: DarkColors.bottomNavItem,
          backgroundColor: DarkColors.bottomNavBackground,
          unselectedItemColor: DarkColors.bottomNavItemNotSelected),
      iconTheme: const IconThemeData(color: DarkColors.white),
      // Copy Style of parent and only modify colors
      textTheme: globalAppTheme.textTheme.copyWith(
        headlineSmall: globalAppTheme.textTheme.headlineSmall
            ?.copyWith(color: LightColors.white),
        bodyLarge: globalAppTheme.textTheme.bodyLarge
            ?.copyWith(color: LightColors.white),
      ),
      bottomAppBarTheme:
          const BottomAppBarTheme(color: DarkColors.bottomNavBackground),
    );
  }

  static AppBarTheme lightAppBarTheme() {
    return const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: LightColors.appBarBackground,
        foregroundColor: LightColors.appBarContent);
  }

  static AppBarTheme darkAppBarTheme() {
    return const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: DarkColors.appBarBackground,
        foregroundColor: DarkColors.appBarContent);
  }
}

class ThemeState with ChangeNotifier {
  String _userTheme = StringConstants.themePreferenceLight;

  String get userTheme => _userTheme;

  get brightness => MediaQueryData.fromView(
          PlatformDispatcher.instance.views.first.physicalSize as FlutterView)
      .platformBrightness;

  set userTheme(String value) {
    _userTheme = value;
    notifyListeners();
  }

  ThemeMode get theme {
    switch (userTheme) {
      case StringConstants.themePreferenceLight:
        return ThemeMode.light;
      case StringConstants.themePreferenceDark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  ApplicationColors get colors {
    switch (userTheme) {
      case StringConstants.themePreferenceLight:
        return ApplicationColors.light;
      case StringConstants.themePreferenceDark:
        return ApplicationColors.dark;
      default:
        {
          switch (brightness) {
            case Brightness.dark:
              return ApplicationColors.dark;
            default:
              return ApplicationColors.light;
          }
        }
    }
  }
}
