import 'package:ai_project_lab_pannon/features/common/core/view/components/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../../../../shared/style/colors_manager.dart';
import '../../../../../shared/style/fonts_manager.dart';
import '../../../../home/view/home_page.dart';
import '../../../core/view/components/custom_appbar.dart';
import '../../../core/view/components/custom_button.dart';
import '../../view_model/auth_cubit.dart';
import '../../view_model/auth_state.dart';

class AuthVerificationScreen extends StatelessWidget {
  const AuthVerificationScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Email Verification",
        onPressed: () {},
        isLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              var cubit = AuthCubit.get(context);
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    IconlyBroken.message,
                    size: 120,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 34.0),
                    child: Text(
                      "We have sent email  with otp on your email , please check your email address and enter your otp",
                      style: FontsManagerHelper.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 34.0),
                    child: OtpTextField(
                      numberOfFields: 6,
                      borderColor: ColorManagerHelper.kMainColor,
                      focusedBorderColor: ColorManagerHelper.kMainColor,
                      cursorColor: ColorManagerHelper.kMainColor,
                      //set to true to show as box or false to show as dash
                      showFieldAsBox: true,
                      //runs when a code is typed in
                      onCodeChanged: (String code) {
                        //handle validation or checks here
                      },
                      //runs when every textfield is filled
                      onSubmit: (String verificationCode) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return FutureBuilder<bool>(
                              future: cubit.confirmOtp(verificationCode,
                                  email), // Simulate verification
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // Show loading indicator while waiting
                                  return const AlertDialog(
                                    content: Row(
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(width: 20),
                                        Text("Verifying..."),
                                      ],
                                    ),
                                  );
                                } else if (snapshot.hasData &&
                                    snapshot.data == true) {
                                  // If the code is correct, navigate to the next page
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()),
                                    );
                                    ToastManager.customToastSuccess(
                                        context: context,
                                        title:
                                            "Verification Successfully\n Welcome Back");
                                  });
                                  return const SizedBox
                                      .shrink(); // Empty dialog
                                } else {
                                  // Show error message if the code is incorrect
                                  return AlertDialog(
                                    title: const Text("Verification Failed"),
                                    content: const Text(
                                        "The entered code is incorrect."),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: const Text("Retry"),
                                      ),
                                    ],
                                  );
                                }
                              },
                            );
                          },
                        );
                      }, // end onSubmit
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 34.0, vertical: 24),
                    child: CustomButton(
                      onPressed: () {},
                      buttonText: "Resend OTP",
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            IconlyBroken.arrowLeft2,
                            size: 30,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 14),
                          Text("Back to login",
                              style: FontsManagerHelper.bodyLarge
                                  .copyWith(color: Colors.black)),
                        ],
                      ))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
