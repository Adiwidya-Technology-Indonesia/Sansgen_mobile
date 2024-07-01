import 'package:flutter/material.dart';
import 'package:sansgen/theme/app_colors.dart';

@immutable
class AppTheme {
  const AppTheme._();

  static final light = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      background: ColorLight.appBackground,
      onBackground: ColorLight.appOnBackground, // Text on background color
      primary: ColorLight.greenPrimary,
      onPrimary: ColorLight.textPrimary, // Text on primary color
      secondary: ColorLight.greenLight,
      onSecondary: ColorLight.textSecondary, // Text on secondary color
      onSurface: ColorLight.textTertiary, // Text on surface color
      error: ColorLight.redPrimary,
    ),
  );
}
