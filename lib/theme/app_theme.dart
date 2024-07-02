import 'package:flutter/material.dart';
import 'package:sansgen/theme/app_colors.dart';

@immutable
class AppTheme {
  const AppTheme._();

  static final light = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      background: ColorLight.whitePrimary,
      onBackground: ColorLight.blackPrimary, // Text on background color
      primary: ColorLight.whitePrimary,
      onPrimary: ColorLight.textPrimary, // Text on primary color
      secondary: ColorLight.greenLight,
      onSecondary: ColorLight.textSecondary, // Text on secondary color
      surface: ColorLight.greenPrimary,
      onSurface: ColorLight.textTertiary, // Text on surface color
      tertiary: ColorLight.blueGrey,
      error: ColorLight.redPrimary,
    ),
  );
}
