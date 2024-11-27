import 'package:flutter/cupertino.dart';

class CustomNoItem extends StatelessWidget {
  final String text;
  const CustomNoItem({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600),
        ));
  }
}
