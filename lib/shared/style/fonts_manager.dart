import 'package:flutter/material.dart';
/// A utility class for managing font styles, sizes, and weights used throughout the application.
/// This class provides a set of predefined font constants for consistent typography.
class FontsManagerHelper {
  /// Font sizes in points
  static const double fontSize8 = 8.0;      ///< Font size for very small text, often used for fine print or footnotes.
  static const double fontSize10 = 10.0;    ///< Font size for small text, suitable for captions or secondary information.
  static const double fontSize12 = 12.0;    ///< Font size for body text or minor UI elements.
  static const double fontSize14 = 14.0;    ///< Font size for standard body text or smaller headers.
  static const double fontSize16 = 16.0;    ///< Font size for standard body text or medium-sized headers.
  static const double fontSize18 = 18.0;    ///< Font size for larger body text or small headings.
  static const double fontSize20 = 20.0;    ///< Font size for headings or prominent text.
  static const double fontSize22 = 22.0;    ///< Font size for subheadings or emphasized text.
  static const double fontSize24 = 24.0;    ///< Font size for main headings or important text.
  static const double fontSize26 = 26.0;    ///< Font size for larger headings or highlighted text.
  static const double fontSize28 = 28.0;    ///< Font size for extra-large headings or key information.
  static const double fontSize30 = 30.0;    ///< Font size for prominent headings or display text.
  static const double fontSize32 = 32.0;    ///< Font size for very prominent headings or display content.
  static const double fontSize34 = 34.0;    ///< Font size for major headings or significant text.
  static const double fontSize36 = 36.0;    ///< Font size for large headings or standout text.
  static const double fontSize38 = 38.0;    ///< Font size for extra-large headings or feature content.
  static const double fontSize40 = 40.0;    ///< Font size for display text or very prominent headings.

  /// Font weights
  static const FontWeight thin = FontWeight.w100;     ///< Thin font weight for very light text.
  static const FontWeight extraLight = FontWeight.w200; ///< Extra light font weight for light text.
  static const FontWeight light = FontWeight.w300;    ///< Light font weight for soft, readable text.
  static const FontWeight regular = FontWeight.w400;  ///< Regular font weight for standard text.
  static const FontWeight medium = FontWeight.w500;   ///< Medium font weight for slightly emphasized text.
  static const FontWeight semiBold = FontWeight.w600; ///< Semi-bold font weight for important text.
  static const FontWeight bold = FontWeight.w700;     ///< Bold font weight for prominent text.
  static const FontWeight extraBold = FontWeight.w800;///< Extra-bold font weight for strong emphasis.
  static const FontWeight black = FontWeight.w900;    ///< Black font weight for maximum emphasis.

  /// Font families
  static const String fontFamilyDefault = 'Roboto';       ///< Default font family for most text.
  static const String fontFamilyAlternative = 'Arial';    ///< Alternative font family for generic text.
  static const String fontFamilySerif = 'Georgia';        ///< Serif font family for traditional or formal text.
  static const String fontFamilySansSerif = 'Helvetica';  ///< Sans-serif font family for modern, clean text.

  /// Common text styles
  static const TextStyle displayLarge = TextStyle(
    fontSize: fontSize40,
    fontWeight: bold,
    fontFamily: fontFamilyDefault,
  );  ///< Large display text style for headlines or feature content.
  static const TextStyle displayMedium = TextStyle(
    fontSize: fontSize34,
    fontWeight: semiBold,
    fontFamily: fontFamilyDefault,
  );  ///< Medium display text style for secondary headings or prominent text.
  static const TextStyle displaySmall = TextStyle(
    fontSize: fontSize30,
    fontWeight: medium,
    fontFamily: fontFamilyDefault,
  );  ///< Small display text style for less prominent headings.
  static const TextStyle headlineLarge = TextStyle(
    fontSize: fontSize28,
    fontWeight: bold,
    fontFamily: fontFamilyDefault,
  );  ///< Large headline text style for major sections.
  static const TextStyle headlineMedium = TextStyle(
    fontSize: fontSize24,
    fontWeight: semiBold,
    fontFamily: fontFamilyDefault,
  );  ///< Medium headline text style for important sections.
  static const TextStyle headlineSmall = TextStyle(
    fontSize: fontSize20,
    fontWeight: medium,
    fontFamily: fontFamilyDefault,
  );  ///< Small headline text style for sub-sections.
  static const TextStyle titleLarge = TextStyle(
    fontSize: fontSize18,
    fontWeight: semiBold,
    fontFamily: fontFamilyDefault,
  );  ///< Large title text style for main headings or titles.
  static const TextStyle titleMedium = TextStyle(
    fontSize: fontSize16,
    fontWeight: medium,
    fontFamily: fontFamilyDefault,
  );  ///< Medium title text style for secondary titles.
  static const TextStyle titleSmall = TextStyle(
    fontSize: fontSize12,
    fontWeight: semiBold,
    fontFamily: fontFamilyDefault,
  );  ///< Small title text style for less prominent titles.
  static const TextStyle bodyLarge = TextStyle(
    fontSize: fontSize16,
    fontWeight: regular,
    fontFamily: fontFamilyDefault,
  );  ///< Large body text style for main content.
  static const TextStyle bodyMedium = TextStyle(
    fontSize: fontSize14,
    fontWeight: regular,
    fontFamily: fontFamilyDefault,
  );  ///< Medium body text style for paragraphs or detailed text.
  static const TextStyle bodySmall = TextStyle(
    fontSize: fontSize12,
    fontWeight: regular,
    fontFamily: fontFamilyDefault,
  );  ///< Small body text style for supplementary content.
  static const TextStyle labelLarge = TextStyle(
    fontSize: fontSize14,
    fontWeight: medium,
    fontFamily: fontFamilyDefault,
  );  ///< Large label text style for form labels or indicators.
  static const TextStyle labelMedium = TextStyle(
    fontSize: fontSize12,
    fontWeight: medium,
    fontFamily: fontFamilyDefault,
  );  ///< Medium label text style for smaller form labels or indicators.
  static const TextStyle labelSmall = TextStyle(
    fontSize: fontSize10,
    fontWeight: medium,
    fontFamily: fontFamilyDefault,
  );  ///< Small label text style for tiny indicators or labels.
  static const TextStyle caption = TextStyle(
    fontSize: fontSize12,
    fontWeight: light,
    fontFamily: fontFamilyDefault,
  );  ///< Caption text style for image descriptions or minor annotations.
  static const TextStyle overline = TextStyle(
    fontSize: fontSize10,
    fontWeight: light,
    fontFamily: fontFamilyDefault,
  );  ///< Overline text style for small text that needs to stand out, often used for labels.
  static const TextStyle button = TextStyle(
    fontSize: fontSize16,
    fontWeight: bold,
    fontFamily: fontFamilyDefault,
  );  ///< Button text style for call-to-action buttons.
  static const TextStyle subtitle1 = TextStyle(
    fontSize: fontSize18,
    fontWeight: regular,
    fontFamily: fontFamilyDefault,
  );  ///< Subtitle text style for secondary headings or important supplementary text.
  static const TextStyle subtitle2 = TextStyle(
    fontSize: fontSize16,
    fontWeight: regular,
    fontFamily: fontFamilyDefault,
  );  ///< Secondary subtitle text style for less emphasized headings.
  static const TextStyle heading1 = TextStyle(
    fontSize: fontSize34,
    fontWeight: bold,
    fontFamily: fontFamilyDefault,
  );  ///< Primary heading text style for main sections or pages.
  static const TextStyle heading2 = TextStyle(
    fontSize: fontSize28,
    fontWeight: semiBold,
    fontFamily: fontFamilyDefault,
  );  ///< Secondary heading text style for sub-sections or key points.
  static const TextStyle heading3 = TextStyle(
    fontSize: fontSize22,
    fontWeight: medium,
    fontFamily: fontFamilyDefault,
  );  ///< Tertiary heading text style for sub-sections or less prominent points.
  static const TextStyle heading4 = TextStyle(
    fontSize: fontSize20,
    fontWeight: medium,
    fontFamily: fontFamilyDefault,
  );  ///< Heading text style for smaller sections or detailed headers.
  static const TextStyle heading5 = TextStyle(
    fontSize: fontSize18,
    fontWeight: medium,
    fontFamily: fontFamilyDefault,
  );  ///< Heading text style for minor sections or less emphasized headers.
  static const TextStyle heading6 = TextStyle(
    fontSize: fontSize16,
    fontWeight: medium,
    fontFamily: fontFamilyDefault,
  );  ///< Small heading text style for sub-sections or fine details.
  static const TextStyle body1 = TextStyle(
    fontSize: fontSize16,
    fontWeight: regular,
    fontFamily: fontFamilyDefault,
  );  ///< Body text style for main content or standard text.
  static const TextStyle body2 = TextStyle(
    fontSize: fontSize14,
    fontWeight: regular,
    fontFamily: fontFamilyDefault,
  );  ///< Body text style for secondary content or smaller text.
  /// Private constructor to prevent instantiation.
  const FontsManagerHelper._();
}
