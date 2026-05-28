import 'package:flutter/material.dart';

ThemeData buildSiteTheme() {
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
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 56,
        fontWeight: FontWeight.w700,
        height: 1.05,
        color: SiteColors.text,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 34,
        fontWeight: FontWeight.w700,
        height: 1.1,
        color: SiteColors.text,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: SiteColors.text,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: SiteColors.text,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Verdana',
        fontSize: 16,
        height: 1.7,
        color: SiteColors.text,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Verdana',
        fontSize: 14,
        height: 1.6,
        color: SiteColors.textMuted,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Verdana',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: SiteColors.navy,
      ),
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
