import 'package:flutter/material.dart';

import '../../../../../shared/style/colors_manager.dart';
import '../../view_model/auth_cubit.dart';

class AuthCustomRememberAndForgot extends StatelessWidget {
  const AuthCustomRememberAndForgot({super.key, required this.cubit});

  final cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          onChanged: (value) {
            cubit.signInChangeRememberMe();
          },
          checkColor: Colors.white,
          fillColor: WidgetStateProperty.all(cubit.signInRememberMe
              ? ColorManagerHelper.kBlackColor
              : Colors.transparent),
          value: AuthCubit.get(context).signInRememberMe,
        ),
        const Text(
          "Remember Me",
          style: TextStyle(
            color: ColorManagerHelper.kBlackColor,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        TextButton(
          child: const Text(
            "Forgot Password",
            style: TextStyle(
              color: ColorManagerHelper.kBlackColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
