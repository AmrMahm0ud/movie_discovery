import 'package:flutter/material.dart';
import 'package:movie_discovery/config/theme/color_manager.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: ColorManager.primary,
    scaffoldBackgroundColor: ColorManager.background,
    colorScheme: ColorScheme.light(
      primary: ColorManager.primary,
      secondary: ColorManager.secondary,
      surface: ColorManager.surface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorManager.white,
      foregroundColor: ColorManager.textPrimary,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: ColorManager.textPrimary,
      ),
    ),
    textTheme: _textTheme,
    cardTheme: CardTheme(
      color: ColorManager.cardBackground,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    iconTheme: const IconThemeData(
      color: ColorManager.iconColor,
    ),
    dividerColor: ColorManager.divider,
  );

  static const TextTheme _textTheme = TextTheme(
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: ColorManager.textPrimary,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: ColorManager.textPrimary,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: ColorManager.textSecondary,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: ColorManager.textHint,
    ),
  );
}
