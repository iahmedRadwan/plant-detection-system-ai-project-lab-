import 'package:flutter/material.dart';

class ColorManagerHelper {
  /// main app color
  static const Color kMainColor = Color(0xff00577D);

  /// main white color
  static const Color kWhiteColor = Color(0xffffffff);

  /// main Orange color
  static const Color kOrangeColor = Colors.deepOrangeAccent;

  /// main Grey color
  static const Color kGreyColor = Color(0xff808080);

  /// main Border color
  static const Color kBorderColor = Color(0xff000000);

  /// main Black color
  static const Color kBlackColor = Color(0xff000000);

  /// main Red color
  static const Color redColor = Colors.red;

  static convertColor(colorString) {
    if (colorString != null) {
      String colorHex =
          colorString.startsWith('#') ? colorString : '#$colorString';
      int colorInt = int.parse(colorHex.replaceAll("#", "ff"), radix: 16);
      Color myColor = Color(colorInt);
      return myColor;
    }
  }
}
