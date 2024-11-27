import 'package:flutter/material.dart';
import '../../../../../shared/style/colors_manager.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final String buttonText;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? height;
  final double? width;
  final Color? textColor;
  final double? fontSize;
  final double? borderRadius;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.height,
    this.width,
    this.borderRadius,
    this.fontSize,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height ?? 55,
        width: width ?? double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            elevation: WidgetStateProperty.all(0.0),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 16),
              side: BorderSide(
                  color: borderColor ?? ColorManagerHelper.kMainColor,
                  style: BorderStyle.solid,
                  width: 1.3),
            )),
            backgroundColor: WidgetStateProperty.all(
                backgroundColor ?? ColorManagerHelper.kMainColor),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: fontSize ?? 13,
              fontWeight: FontWeight.w600,
              color: textColor ?? ColorManagerHelper.kWhiteColor,
            ),
          ),
        ));
  }
}
