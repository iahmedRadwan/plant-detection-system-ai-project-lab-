import 'package:flutter/material.dart';
import 'colors_manager.dart';
import 'fonts_manager.dart';
class ThemeManagerHelper {
  // Light theme
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      textTheme: TextTheme(

        // Display styles
        displayLarge: FontsManagerHelper.displayLarge.copyWith(
            color: ColorManagerHelper.kBlackColor),
        displayMedium: FontsManagerHelper.displayMedium.copyWith(
            color: ColorManagerHelper.kBlackColor),
        displaySmall: FontsManagerHelper.displaySmall.copyWith(
            color: ColorManagerHelper.kBlackColor),
        // Headline styles
        headlineLarge: FontsManagerHelper.headlineLarge.copyWith(
            color: ColorManagerHelper.kBlackColor),
        headlineMedium: FontsManagerHelper.headlineMedium.copyWith(
            color: ColorManagerHelper.kBlackColor),
        headlineSmall: FontsManagerHelper.headlineSmall.copyWith(
            color: ColorManagerHelper.kBlackColor),
        // Title styles
        titleLarge: FontsManagerHelper.titleLarge.copyWith(
            color: ColorManagerHelper.kBlackColor),
        titleMedium: FontsManagerHelper.titleMedium.copyWith(
            color: ColorManagerHelper.kBlackColor),
        titleSmall: FontsManagerHelper.titleSmall.copyWith(
            color: ColorManagerHelper.kBlackColor),
        // Body text styles
        bodyLarge: FontsManagerHelper.bodyLarge.copyWith(
            color: ColorManagerHelper.kBlackColor),
        bodyMedium: FontsManagerHelper.bodyMedium.copyWith(
            color: ColorManagerHelper.kBlackColor),
        bodySmall: FontsManagerHelper.bodySmall.copyWith(
            color: ColorManagerHelper.kBlackColor),
        // Label text styles
        labelLarge: FontsManagerHelper.labelLarge
            .copyWith(color: ColorManagerHelper.kBlackColor),
        labelMedium: FontsManagerHelper.labelMedium
            .copyWith(color: ColorManagerHelper.kBlackColor),
        labelSmall: FontsManagerHelper.labelSmall
            .copyWith(color: ColorManagerHelper.kBlackColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(
          color: ColorManagerHelper.kGreyColor,
          fontSize: 11,
        ),
        labelStyle: const TextStyle(
          color: ColorManagerHelper.kGreyColor,
          fontSize: 13.5,
        ),
        filled: true,
        fillColor: Colors.blueGrey.withOpacity(0.055),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular( 16),
            borderSide: BorderSide(
                color:  Colors.blueGrey.withOpacity(0.030),
            ),
            gapPadding: 5),
        enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular( 16),
            borderSide: BorderSide(
              color:  Colors.blueGrey.withOpacity(0.030),
            ),
            gapPadding: 5),
        errorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular( 16),
            borderSide: BorderSide(
              color:  Colors.blueGrey.withOpacity(0.030),
            ),
            gapPadding: 5),
        focusedErrorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular( 16),
            borderSide: BorderSide(
              color:  Colors.blueGrey.withOpacity(0.030),
            ),
            gapPadding: 5),
      ),
      useMaterial3: false,
      scaffoldBackgroundColor: Colors.white,
      // Light background color
      appBarTheme: const AppBarTheme(
          color: ColorManagerHelper.kWhiteColor // Light AppBar color
      ),
    );
  }

// Dark theme
  static ThemeData darkTheme() {
    return ThemeData(

      brightness: Brightness.dark,

      textTheme: TextTheme(
        // Display styles
        displayLarge: FontsManagerHelper.displayLarge.copyWith(
            color: ColorManagerHelper.kWhiteColor),
        displayMedium: FontsManagerHelper.displayMedium.copyWith(
            color: ColorManagerHelper.kWhiteColor),
        displaySmall: FontsManagerHelper.displaySmall.copyWith(
            color: ColorManagerHelper.kWhiteColor),
        // Headline styles
        headlineLarge: FontsManagerHelper.headlineLarge.copyWith(
            color: ColorManagerHelper.kWhiteColor),
        headlineMedium: FontsManagerHelper.headlineMedium.copyWith(
            color: ColorManagerHelper.kWhiteColor),
        headlineSmall: FontsManagerHelper.headlineSmall.copyWith(
            color: ColorManagerHelper.kWhiteColor),
        // Title styles
        titleLarge: FontsManagerHelper.titleLarge.copyWith(
            color: ColorManagerHelper.kWhiteColor),
        titleMedium: FontsManagerHelper.titleMedium.copyWith(
            color: ColorManagerHelper.kWhiteColor),
        titleSmall: FontsManagerHelper.titleSmall.copyWith(
            color: ColorManagerHelper.kWhiteColor),
        // Body text styles
        bodyLarge: FontsManagerHelper.bodyLarge.copyWith(
            color: ColorManagerHelper.kWhiteColor),
        bodyMedium: FontsManagerHelper.bodyMedium.copyWith(
            color: ColorManagerHelper.kWhiteColor),
        bodySmall: FontsManagerHelper.bodySmall.copyWith(
            color: ColorManagerHelper.kWhiteColor),
        // Label text styles
        labelLarge: FontsManagerHelper.labelLarge.copyWith(
            color: ColorManagerHelper.kWhiteColor),
        labelMedium: FontsManagerHelper.labelMedium.copyWith(
            color: ColorManagerHelper.kWhiteColor),
        labelSmall: FontsManagerHelper.labelSmall.copyWith(
            color: ColorManagerHelper.kWhiteColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(
          color: ColorManagerHelper.kGreyColor,
          fontSize: 11,
        ),
        labelStyle: const TextStyle(
          color: ColorManagerHelper.kGreyColor,
          fontSize: 13.5,
        ),
        filled: true,
        fillColor: Colors.blueGrey.withOpacity(0.055),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular( 16),
            borderSide: BorderSide(
              color:  Colors.blueGrey.withOpacity(0.030),
            ),
            gapPadding: 5),
        enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular( 16),
            borderSide: BorderSide(
              color:  Colors.blueGrey.withOpacity(0.030),
            ),
            gapPadding: 5),
        errorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular( 16),
            borderSide: BorderSide(
              color:  Colors.blueGrey.withOpacity(0.030),
            ),
            gapPadding: 5),
        focusedErrorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular( 16),
            borderSide: BorderSide(
              color:  Colors.blueGrey.withOpacity(0.030),
            ),
            gapPadding: 5),
      ),
      useMaterial3: false,
      scaffoldBackgroundColor: const Color(0xff121212),
      // Dark background color
      appBarTheme: const AppBarTheme(
          color: ColorManagerHelper.kBlackColor // Dark AppBar color
      ),
    );
  }
}