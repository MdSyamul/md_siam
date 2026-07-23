import 'package:flutter/material.dart';

ThemeData buildSiteTheme() {
  final uiTextTheme = const TextTheme().apply(fontFamily: 'IBM Plex Sans');
  final textTheme = uiTextTheme.copyWith(
    displayLarge: const TextStyle(
      fontFamily: 'Merriweather',
      fontSize: 56,
      fontWeight: FontWeight.w700,
      height: 1.08,
      color: SiteColors.text,
    ),
    displayMedium: const TextStyle(
      fontFamily: 'Merriweather',
      fontSize: 42,
      fontWeight: FontWeight.w700,
      height: 1.1,
      color: SiteColors.text,
    ),
    displaySmall: const TextStyle(
      fontFamily: 'Merriweather',
      fontSize: 34,
      fontWeight: FontWeight.w700,
      height: 1.15,
      color: SiteColors.text,
    ),
    headlineMedium: const TextStyle(
      fontFamily: 'Merriweather',
      fontSize: 28,
      fontWeight: FontWeight.w700,
      height: 1.2,
      color: SiteColors.text,
    ),
    titleLarge: const TextStyle(
      fontFamily: 'Merriweather',
      fontSize: 22,
      fontWeight: FontWeight.w700,
      height: 1.25,
      color: SiteColors.text,
    ),
    titleMedium: const TextStyle(
      fontFamily: 'Merriweather',
      fontSize: 18,
      fontWeight: FontWeight.w700,
      height: 1.3,
      color: SiteColors.text,
    ),
    bodyLarge: const TextStyle(
      fontFamily: 'IBM Plex Sans',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.65,
      color: SiteColors.text,
    ),
    bodyMedium: const TextStyle(
      fontFamily: 'IBM Plex Sans',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.5,
      color: SiteColors.textMuted,
    ),
    bodySmall: const TextStyle(
      fontFamily: 'IBM Plex Sans',
      fontSize: 13,
      fontWeight: FontWeight.w400,
      height: 1.5,
      color: SiteColors.textMuted,
    ),
    labelLarge: const TextStyle(
      fontFamily: 'IBM Plex Sans',
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.2,
      color: SiteColors.navy,
    ),
    labelMedium: const TextStyle(
      fontFamily: 'IBM Plex Sans',
      fontSize: 13,
      fontWeight: FontWeight.w600,
      height: 1.25,
      color: SiteColors.navy,
    ),
    labelSmall: const TextStyle(
      fontFamily: 'IBM Plex Sans',
      fontSize: 12,
      fontWeight: FontWeight.w700,
      height: 1.25,
      color: SiteColors.navy,
    ),
  );

  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: SiteColors.background,
    colorScheme: const ColorScheme.light(
      primary: SiteColors.navy,
      secondary: SiteColors.cyan,
      surface: SiteColors.surface,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: SiteColors.text,
    ),
    textTheme: textTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: textTheme.labelLarge,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: textTheme.labelLarge,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(textStyle: textTheme.labelLarge),
    ),
    chipTheme: ChipThemeData(
      labelStyle: textTheme.labelMedium,
      secondaryLabelStyle: textTheme.labelMedium?.copyWith(color: Colors.white),
    ),
  );
}

class SiteColors {
  static const background = Color(0xFFF7F2E8);
  static const surface = Color(0xFFFFFBF4);
  static const surfaceMuted = Color(0xFFF0E4CF);
  static const navy = Color(0xFF0F2D3A);
  static const cyan = Color(0xFF3B768A);
  static const text = Color(0xFF16242B);
  static const textMuted = Color(0xFF5A6A72);
  static const line = Color(0xFFD8C8B0);
}
