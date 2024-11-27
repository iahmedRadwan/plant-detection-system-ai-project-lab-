import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.0,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10) +
          const EdgeInsets.symmetric(vertical: 10),
      color: const Color(0xffD3E3F1),
    );
  }
}