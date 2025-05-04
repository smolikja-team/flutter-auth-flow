import 'package:flutter/material.dart';

/// Text styles for the application
/// Following Material Design 3 typography system
class TextStyles {
  // MARK: HEADLINE STYLES

  // Headline Large - Regular (32px)
  static TextStyle get headlineLarge => const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
      );

  // Headline Large Bold - Bold (32px)
  static TextStyle get headlineLargeBold => const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      );

  // Headline Medium - Regular (28px)
  static TextStyle get headlineMedium => const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
      );

  // Headline Medium Bold - Bold (28px)
  static TextStyle get headlineMediumBold => const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      );

  // Headline Small Bold - Bold (24px)
  static TextStyle get headlineSmallBold => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );

  // MARK: DISPLAY STYLES

  // Display Large - Regular (57px)
  static TextStyle get displayLarge => const TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
      );

  // MARK: TITLE STYLES

  // Title Large - Regular (22px)
  static TextStyle get titleLarge => const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
      );

  // Title Large Bold - Bold (22px)
  static TextStyle get titleLargeBold => const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      );

  // Title Medium - Medium (16px)
  static TextStyle get titleMedium => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );

  // Title Medium Semibold - Semibold (16px)
  static TextStyle get titleMediumSemibold => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
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

  // Label Large Error - Medium (14px)
  static TextStyle get labelLargeError => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  // Label Large Hyperlink - Medium (14px)
  static TextStyle get labelLargeHyperlink => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  // Label Large Disabled - Medium (14px)
  static TextStyle get labelLargeDisabled => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  // MARK: BODY STYLES

  // Body Large - Regular (16px)
  static TextStyle get bodyLarge => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  // Body Large Bold - Bold (16px)
  static TextStyle get bodyLargeBold => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  // Body Large Error - Regular (16px)
  static TextStyle get bodyLargeError => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

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

  // Body Small with reduced opacity - Regular (12px)
  static TextStyle get bodySmallDisabled => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );
}
