import 'package:flutter/material.dart';

import '../../../../../shared/style/colors_manager.dart';

class CustomHeadline extends StatelessWidget {
  final String headlineText;
  final Color? textColor;
  final double? headlineTextSize;

  final FontWeight? textFontWeight;
   const CustomHeadline({super.key,required this.headlineText,this.textColor,this.textFontWeight,this.headlineTextSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      headlineText,
      style: TextStyle(
        fontSize: headlineTextSize??12,
        fontWeight:textFontWeight?? FontWeight.bold,
        color: textColor??ColorManagerHelper.kBlackColor,
      ),
    );
  }
}
