import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../shared/style/colors_manager.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final IconData? prefixIcon;
  final IconButton? suffixIcon;
  final String hintText;
  final String? labelText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final double? radius;
  final int maxLines;
  final double? height;
  final double? width;
  final Color? fillColor;
  final bool? filled;
  final BorderSide? borderSide;
  final Iterable<String>? autofillHints;
  final bool formatSortCode; // New parameter

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.onTap,
    this.obscureText,
    this.maxLines = 1,
    this.fillColor,
    this.filled,
    this.borderSide,
    this.autofillHints,
    this.radius,
    this.formatSortCode = false,
    this.height = 20,
    this.width = 20, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        autofillHints: autofillHints,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onTap: onTap,
        obscureText: obscureText ?? false,
        maxLines: maxLines,
        onChanged: onChanged,
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        textInputAction: TextInputAction.next,
        validator: validator,
        inputFormatters: formatSortCode ? [SortCodeInputFormatter()] : [],
        // Apply formatter conditionally
        textDirection: TextDirection.ltr,
        style: const TextStyle(
          color: Color(0xFF757575),
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          // fillColor: fillColor,
          // filled: filled,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: ColorManagerHelper.kMainColor)
              : null,
          contentPadding:
              EdgeInsets.symmetric(horizontal: width!, vertical: height!),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hintText,
          focusColor: Colors.grey,
          hoverColor: Colors.grey,
          labelText: labelText,
          hintStyle: const TextStyle(
            color: ColorManagerHelper.kGreyColor,
            fontSize: 11,
          ),
          labelStyle: const TextStyle(
            color: ColorManagerHelper.kGreyColor,
            fontSize: 13.5,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 16),
              borderSide: borderSide ??
                  BorderSide(
                    color: Colors.blueGrey.withOpacity(0.030),
                  ),
              gapPadding: 5),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 16),
              borderSide: borderSide ??
                  BorderSide(
                    color: Colors.blueGrey.withOpacity(0.030),
                  ),
              gapPadding: 5),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 16),
              borderSide: borderSide ??
                  BorderSide(
                    color:  Colors.blueGrey.withOpacity(0.030),
                  ),

              gapPadding: 5),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 16),
              borderSide: borderSide ??
                  BorderSide(
                    color:  Colors.blueGrey.withOpacity(0.030),
                  ),

              gapPadding: 5),
        ),
      ),
    );
  }
}

class SortCodeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any non-digit characters
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Limit to a maximum of 6 digits
    final truncatedText = text.length > 6 ? text.substring(0, 6) : text;

    // Format with hyphens (XX-XX-XX)
    String newText = '';
    for (int i = 0; i < truncatedText.length; i++) {
      if (i == 2 || i == 4) {
        newText += '-';
      }
      newText += truncatedText[i];
    }

    // Return the new formatted value
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
