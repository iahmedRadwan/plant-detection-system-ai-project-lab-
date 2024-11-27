import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../../shared/style/colors_manager.dart';
import '../../../../../shared/style/images_manager.dart';
import '../../../../../shared/style/padding_manager.dart';
import '../../../core/view/components/custom_button.dart';
import '../../../core/view/components/custom_phone_text_form_field.dart';
import '../../../core/view/components/custom_text_form_field.dart';
import '../../../core/view/components/custom_toast.dart';
import '../../view_model/auth_cubit.dart';
import '../../view_model/auth_state.dart';
import '../components/auth_custom_hint.dart';
import 'auth_verification_screen.dart';

class AuthSignUpScreen extends StatefulWidget {
  AuthSignUpScreen({super.key});

  @override
  State<AuthSignUpScreen> createState() => _AuthSignUpScreenState();
}

class _AuthSignUpScreenState extends State<AuthSignUpScreen> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is AuthSignUpSuccessState) {
          AuthCubit.get(context).signIn(
              email: emailController.text, password: passwordController.text);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AuthVerificationScreen(
                  email: emailController.text,
                ),
              ));
        }
        if (state is AuthSignUpErrorState) {
          ToastManager.customToastError(context: context, title: state.error);
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage(ImagesManagerHelper.signIn),
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: PaddingManagerHelper.horizontalPadding),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              controller: usernameController,
                              hintText: "Username",
                              prefixIcon: IconlyBroken.profile,
                              validator: (value) {
                                // using regular expression
                                if (value!.isEmpty) {
                                  return "Please enter username";
                                } else {
                                  return null;
                                }
                              },
                              // filled: true,
                              // fillColor: Colors.blueGrey.withOpacity(0.055),
                              // borderSide: BorderSide(
                              //     color: Colors.blueGrey.withOpacity(0.030)),
                            ),
                            CustomTextFormField(
                              controller: emailController,
                              hintText: "Email",
                              keyboardType: TextInputType.emailAddress,
                              // filled: true,
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
                            CustomTextFormField(
                              controller: passwordController,
                              hintText: "Password",
                              obscureText:
                                  AuthCubit.get(context).signUpPasswordEye,
                              keyboardType: TextInputType.text,
                              prefixIcon: IconlyBroken.lock,
                              // filled: true,
                              // fillColor: Colors.blueGrey.withOpacity(0.055),
                              validator: (value) {
                                // using regular expression
                                if (value!.isEmpty) {
                                  return "Please enter password";
                                } else {
                                  return null;
                                }
                              },
                              borderSide: BorderSide(
                                  color: Colors.blueGrey.withOpacity(0.030)),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  AuthCubit.get(context).signUpWithChangeEye();
                                },
                                icon: Icon(
                                    AuthCubit.get(context).signUpPasswordEye
                                        ? Icons.visibility_off
                                        : Icons.visibility_outlined,
                                    color: ColorManagerHelper.kMainColor),
                              ),
                            ),
                            CustomPhoneTextFormField(
                                controller: TextEditingController(),
                                onInputChanged: (PhoneNumber number) {
                                  print(number.phoneNumber);
                                  phoneController.text =
                                      number.phoneNumber ?? '';
                                },
                                onInputValidated: (bool isValid) {
                                  if (!isValid) {
                                    print("Invalid phone number");
                                  }
                                }),
                            const SizedBox(
                              height: PaddingManagerHelper.padding12,
                            ),
                            ConditionalBuilder(
                              condition: state is AuthSignUpLoadingState,
                              builder: (context) => const Center(
                                  child: CircularProgressIndicator()),
                              fallback: (context) => CustomButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    {
                                      cubit.signUp(
                                          username: usernameController.text,
                                          email: emailController.text,
                                          phone: phoneController.text,
                                          password: passwordController.text);
                                    }
                                  }
                                },
                                buttonText: 'Sign Up',
                              ),
                            ),
                            const SizedBox(
                              height: PaddingManagerHelper.padding16,
                            ),
                            AuthCustomHint(
                              accountStatus: "Already have an account? ",
                              pageType: "Sign In",
                              onTapPageType: () {
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(
                              height: PaddingManagerHelper.padding20,
                            ),
                          ],
                        ),
                      ),
                    )
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
