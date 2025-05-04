import 'package:flutter/material.dart';

/// Text styles for the application
/// Following Material Design 3 typography system
class TextStyles {
  // MARK: HEADLINE STYLES

  // Headline Medium - Regular (28px)
  static TextStyle get headlineMedium => const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
      );

  // Headline Small Bold - Bold (24px)
  static TextStyle get headlineSmallBold => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );

  // MARK: TITLE STYLES

  // Title Medium - Medium (16px)
  static TextStyle get titleMedium => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );

  // Title Small - Medium (14px)
  static TextStyle get titleSmall => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  // MARK: LABEL STYLES

  // Label Large - Medium (14px)
  static TextStyle get labelLarge => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  // Label Large Bold - Bold (14px)
  static TextStyle get labelLargeBold => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      );

  // Label Large Hyperlink Semibold - Semibold (14px)
  static TextStyle get labelLargeHyperlinkSemibold => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );

  // Label Large Error Semibold - Semibold (14px)
  static TextStyle get labelLargeErrorSemibold => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );

  // MARK: BODY STYLES

  // Body Medium - Regular (14px)
  static TextStyle get bodyMedium => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );

  // Body Small - Regular (12px)
  static TextStyle get bodySmall => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );
}
