import 'package:ai_project_lab_pannon/features/common/auth/view/screens/auth_verification_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../../../shared/constants/app_constant.dart';
import '../../../../../shared/style/colors_manager.dart';
import '../../../../../shared/style/images_manager.dart';
import '../../../../../shared/style/padding_manager.dart';
import '../../../core/view/components/custom_button.dart';
import '../../../core/view/components/custom_text_form_field.dart';
import '../../../core/view/components/custom_toast.dart';
import '../../view_model/auth_cubit.dart';
import '../../view_model/auth_state.dart';
import '../components/auth_custom_hint.dart';
import '../components/auth_custom_remember_forgot.dart';
import 'auth_sign_up_screen.dart';

class AuthSignInPage extends StatelessWidget {
  /// Sign In With Email And Password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ///  Sign In Form Key
  final formKey = GlobalKey<FormState>();

  AuthSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is AuthSignInSuccessState) {
          AppConstantsHelper.token = state.token;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AuthVerificationScreen(email: emailController.text),
              ));
        }
        if (state is AuthSignInErrorState) {
          ToastManager.customToastError(context: context, title: state.error);
        }
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// logo image
                    const Image(
                      image: AssetImage(ImagesManagerHelper.signIn),
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    /// every thing other
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: PaddingManagerHelper.horizontalPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /// Email Text Form Field
                          CustomTextFormField(
                            controller: emailController,
                            hintText: "Email Address",
                            keyboardType: TextInputType.emailAddress,
                            filled: true,
                            // fillColor: Colors.blueGrey.withOpacity(0.055),
                            // borderSide: BorderSide(
                            //     color: Colors.blueGrey.withOpacity(0.030)),
                            validator: (value) {
                              // using regular expression
                              if (!RegExp(
                                      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$')
                                  .hasMatch(value!)) {
                                return "Please enter valid email";
                              } else if (value.isEmpty) {
                                return "Please enter valid email";
                              } else {
                                return null;
                              }
                            },
                            prefixIcon: IconlyBroken.message,
                          ),

                          /// Password Text Form Field
                          CustomTextFormField(
                            controller: passwordController,
                            hintText: "Password",
                            // filled: true,
                            // fillColor: Colors.blueGrey.withOpacity(0.055),
                            // borderSide: BorderSide(
                            //     color: Colors.blueGrey.withOpacity(0.030)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter valid password";
                              } else {
                                return null;
                              }
                            },
                            obscureText: cubit.signInPasswordEye,
                            prefixIcon: IconlyBroken.lock,
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.signInWithChangeEye();
                              },
                              icon: Icon(
                                  cubit.signInPasswordEye
                                      ? Icons.visibility_off
                                      : Icons.visibility_outlined,
                                  color: ColorManagerHelper.kMainColor),
                            ),
                          ),

                          /// Forgot password and remember me
                          AuthCustomRememberAndForgot(
                            cubit: cubit,
                          ),

                          /// Sign in button
                          ConditionalBuilder(
                            condition: state is AuthSignInLoadingState,
                            builder: (context) => const Center(
                                child: CircularProgressIndicator()),
                            fallback: (context) => CustomButton(
                              buttonText: "Sign In",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.signIn(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          /// Hint
                          AuthCustomHint(
                            accountStatus: "I Don't have an account? ",
                            pageType: "Sign Up",
                            onTapPageType: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AuthSignUpScreen()));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
