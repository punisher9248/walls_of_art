import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTypography {
  AppTypography._();

  // Font Families
  static String get _spaceGrotesk => GoogleFonts.spaceGrotesk().fontFamily!;
  static String get _inter => GoogleFonts.inter().fontFamily!;
  static String get _jetBrainsMono => GoogleFonts.jetBrainsMono().fontFamily!;

  // Display Styles (Space Grotesk)
  static TextStyle displayLarge = TextStyle(
    fontFamily: _spaceGrotesk,
    fontSize: 48,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.44,
    height: 0.95,
    color: AppColors.textPrimary,
  );

  static TextStyle displayMedium = TextStyle(
    fontFamily: _spaceGrotesk,
    fontSize: 36,
    fontWeight: FontWeight.w600,
    letterSpacing: -1.08,
    height: 1.0,
    color: AppColors.textPrimary,
  );

  static TextStyle displaySmall = TextStyle(
    fontFamily: _spaceGrotesk,
    fontSize: 30,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.9,
    height: 1.1,
    color: AppColors.textPrimary,
  );

  // Headline Styles (Space Grotesk)
  static TextStyle headlineLarge = TextStyle(
    fontFamily: _spaceGrotesk,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.48,
    color: AppColors.textPrimary,
  );

  static TextStyle headlineMedium = TextStyle(
    fontFamily: _spaceGrotesk,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
    color: AppColors.textPrimary,
  );

  static TextStyle headlineSmall = TextStyle(
    fontFamily: _spaceGrotesk,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.36,
    color: AppColors.textPrimary,
  );

  // Title Styles (Space Grotesk)
  static TextStyle titleLarge = TextStyle(
    fontFamily: _spaceGrotesk,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.16,
    color: AppColors.textPrimary,
  );

  static TextStyle titleMedium = TextStyle(
    fontFamily: _spaceGrotesk,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle titleSmall = TextStyle(
    fontFamily: _spaceGrotesk,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  // Body Styles (Inter)
  static TextStyle bodyLarge = TextStyle(
    fontFamily: _inter,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.16,
    height: 1.6,
    color: AppColors.textSecondary,
  );

  static TextStyle bodyMedium = TextStyle(
    fontFamily: _inter,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.5,
    color: AppColors.textSecondary,
  );

  static TextStyle bodySmall = TextStyle(
    fontFamily: _inter,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.4,
    color: AppColors.textSecondary,
  );

  // Label Styles (Inter)
  static TextStyle labelLarge = TextStyle(
    fontFamily: _inter,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  static TextStyle labelMedium = TextStyle(
    fontFamily: _inter,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );

  static TextStyle labelSmall = TextStyle(
    fontFamily: _inter,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: AppColors.textMuted,
  );

  // Data/Technical Styles (JetBrains Mono)
  static TextStyle dataMedium = TextStyle(
    fontFamily: _jetBrainsMono,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.24,
    color: AppColors.textSecondary,
  );

  static TextStyle dataSmall = TextStyle(
    fontFamily: _jetBrainsMono,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: AppColors.textMuted,
  );

  // Get TextTheme for MaterialApp
  static TextTheme get textTheme => TextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: displaySmall,
        headlineLarge: headlineLarge,
        headlineMedium: headlineMedium,
        headlineSmall: headlineSmall,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        titleSmall: titleSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: labelLarge,
        labelMedium: labelMedium,
        labelSmall: labelSmall,
      );
}
