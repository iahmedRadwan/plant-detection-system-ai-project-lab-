import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/style/colors_manager.dart';
import '../../../../../shared/style/fonts_manager.dart';

class AuthCustomHint extends StatelessWidget {
  final String accountStatus;
  final String pageType;
  final Function() onTapPageType;
  const AuthCustomHint({
    super.key,
    required this.accountStatus,
    required this.pageType,
    required this.onTapPageType,
  });
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: accountStatus,
          style: FontsManagerHelper.bodySmall.copyWith(
            color: Colors.black,
          ),
          children: [
            TextSpan(
                text: pageType,
                style: const TextStyle(
                  color: ColorManagerHelper.kMainColor,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()..onTap = onTapPageType),
          ]),
    );
  }
}
