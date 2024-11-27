import 'package:ai_project_lab_pannon/shared/style/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../../../shared/services/local/cache_helper.dart';
import '../../../auth/view/screens/auth_sign_in_screen.dart';

class CustomSkipOnBoardingButton extends StatelessWidget {
  const CustomSkipOnBoardingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CacheHelper.saveData(key: "onBoarding", value: true).then(
          (value) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => AuthSignInPage(),
              ),
              (route) => false,
            );
          },
        );
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("Skip",
              style: TextStyle(
                  fontSize: 15,
                  color: ColorManagerHelper.kMainColor,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            width: 10,
          ),
          Icon(IconlyBroken.arrowRight, color: ColorManagerHelper.kMainColor),
        ],
      ),
    );
  }
}
