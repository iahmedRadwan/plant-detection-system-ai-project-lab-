import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'custom_text_form_field.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.hintText,

  });

  final TextEditingController controller;
  final void Function(String) onChanged;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      hintText: hintText,
      prefixIcon: IconlyBroken.search,
      radius: 14,
      height: 15,
      filled: true,
      fillColor: Colors.blueGrey.withOpacity(0.055),
      borderSide: BorderSide(color: Colors.blueGrey.withOpacity(0.030)),
      onChanged: onChanged,
    );
  }
}
