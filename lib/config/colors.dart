import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color background = Color(0xFF06080D);
  static const Color surface = Color(0xFF0C1017);
  static const Color surfaceHover = Color(0xFF141A24);
  static const Color surfaceLight = Color(0xFF0A0F18);

  // Accent Colors
  static const Color primary = Color(0xFF3B82F6);
  static const Color primaryLight = Color(0xFF60A5FA);
  static const Color primaryDark = Color(0xFF2563EB);
  static const Color primaryGlow = Color(0x4D3B82F6);

  static const Color secondary = Color(0xFFE11D48);
  static const Color secondaryLight = Color(0xFFF43F5E);
  static const Color secondaryGlow = Color(0x4DE11D48);

  // Gradient Colors
  static const Color gradientPurple = Color(0xFF8B5CF6);
  static const Color gradientPink = Color(0xFFEC4899);

  // Text Colors
  static const Color textPrimary = Color(0xFFF1F5F9);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textDark = Color(0xFF475569);

  // Border & Dividers
  static const Color border = Color(0x14FFFFFF);
  static const Color borderLight = Color(0x0AFFFFFF);
  static const Color borderHover = Color(0x26FFFFFF);

  // Semantic Colors
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF3B82F6),
      Color(0xFF8B5CF6),
      Color(0xFFEC4899),
    ],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0C1017),
      Color(0xFF06080D),
    ],
  );

  static LinearGradient heroOverlayGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      const Color(0xFF06080D).withValues(alpha: 0.8),
      const Color(0xFF06080D),
    ],
  );

  // Shadows
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> elevatedCardShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.5),
      blurRadius: 25,
      offset: const Offset(0, 12),
    ),
  ];

  static List<BoxShadow> primaryGlowShadow = [
    BoxShadow(
      color: primary.withValues(alpha: 0.3),
      blurRadius: 20,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> secondaryGlowShadow = [
    BoxShadow(
      color: secondary.withValues(alpha: 0.3),
      blurRadius: 20,
      spreadRadius: 0,
    ),
  ];
}
