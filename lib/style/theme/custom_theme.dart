import 'package:flutter/material.dart';
import 'package:resto_spot/style/colors/custom_colors.dart';
import 'package:resto_spot/style/typography/custom_text_styles.dart';

class CustomTheme {
  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: CustomTextStyles.displayLarge,
      displayMedium: CustomTextStyles.displayMedium,
      displaySmall: CustomTextStyles.displaySmall,
      headlineLarge: CustomTextStyles.headlineLarge,
      headlineMedium: CustomTextStyles.headlineMedium,
      headlineSmall: CustomTextStyles.headlineSmall,
      titleLarge: CustomTextStyles.titleLarge,
      titleMedium: CustomTextStyles.titleMedium,
      titleSmall: CustomTextStyles.titleSmall,
      bodyLarge: CustomTextStyles.bodyLarge,
      bodyMedium: CustomTextStyles.bodyMedium,
      bodySmall: CustomTextStyles.bodySmall,
      labelLarge: CustomTextStyles.labelLarge,
      labelMedium: CustomTextStyles.labelMedium,
      labelSmall: CustomTextStyles.labelSmall,
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
        toolbarTextStyle: _textTheme.titleLarge,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        )));
  }

  static BottomNavigationBarThemeData get _lightBottomNavTheme {
    return BottomNavigationBarThemeData(
      backgroundColor: CustomColors.blue.color,
      selectedItemColor: CustomColors.white.color,
      unselectedItemColor: CustomColors.grey.color,
      type: BottomNavigationBarType.fixed,
    );
  }

  static BottomNavigationBarThemeData get _darkBottomNavTheme {
    return BottomNavigationBarThemeData(
      backgroundColor: CustomColors.black.color,
      selectedItemColor: CustomColors.blue.color,
      unselectedItemColor: CustomColors.grey.color,
      type: BottomNavigationBarType.fixed,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
        brightness: Brightness.light,
        appBarTheme: _appBarTheme,
        textTheme: _textTheme,
        useMaterial3: true,
        colorSchemeSeed: CustomColors.blue.color,
        bottomNavigationBarTheme: _lightBottomNavTheme);
  }

  static ThemeData get darkTheme {
    return ThemeData(
        brightness: Brightness.dark,
        appBarTheme: _appBarTheme,
        textTheme: _textTheme,
        useMaterial3: true,
        colorSchemeSeed: CustomColors.blue.color,
        bottomNavigationBarTheme: _darkBottomNavTheme);
  }
}
