import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../shared/style/fonts_manager.dart';
import '../../../core/view/components/custom_appbar.dart';
import '../../../core/view/components/custom_button.dart';
import '../../../core/view/components/custom_text_form_field.dart';
import '../../../core/view/components/custom_toast.dart';

class AuthAddUser extends StatefulWidget {
  const AuthAddUser({super.key});

  @override
  State<AuthAddUser> createState() => _AuthAddUserState();
}

class _AuthAddUserState extends State<AuthAddUser> {
  /// Sign In With Email And Password
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late final supabase;
  String phoneNumber = "";
  String initialCountry = 'EG';
  PhoneNumber number = PhoneNumber(isoCode: 'EG');

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();

    supabase = Supabase.instance.client;
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Add a New User",
          onPressed: () {},
          isLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                CustomTextFormField(
                  controller: nameController,
                  hintText: "User Name",
                  keyboardType: TextInputType.name,
                  filled: true,
                  // fillColor: Colors.blueGrey.withOpacity(0.055),
                  // borderSide: BorderSide(
                  //     color: Colors.blueGrey.withOpacity(0.030)),
                  validator: (value) {
                    // using regular expression
                    if (value!.isEmpty) {
                      return "Please enter valid name";
                    } else {
                      return null;
                    }
                  },
                  prefixIcon: IconlyBroken.profile,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: InternationalPhoneNumberInput(
                    spaceBetweenSelectorAndTextField: 0,
                    onInputChanged: (PhoneNumber number) {
                      print(number.phoneNumber);
                      phoneNumber = number.phoneNumber!;
                    },
                    onInputValidated: (bool value) {
                      print(value);
                    },
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      useBottomSheetSafeArea: true,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    initialValue: number,
                    textFieldController: phoneController,
                    formatInput: true,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputBorder: const OutlineInputBorder(),
                    onSaved: (PhoneNumber number) {
                      print('On Saved: $number');
                    },
                  ),
                ),

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
                  obscureText: true,
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
                  prefixIcon: IconlyBroken.lock,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 60.0, vertical: 30),
                  child: CustomButton(
                    onPressed: () async {
                      print(phoneNumber);
                      await supabase.auth.signUp(
                        email: emailController.text,
                        password: passwordController.text,
                        data: {"username": nameController.text},
                      ).then((value) {
                        print(value.user);
                        print(value.session);
                        ToastManager.customToastSuccess(
                            context: context, title: "User Created");
                        emailController.clear();
                        passwordController.clear();
                        setState(() {});
                      }).catchError((error) {
                        ToastManager.customToastError(
                            context: context, title: error.message);
                        print(error.message);
                        emailController.clear();
                        passwordController.clear();

                        setState(() {});
                      });
                    },
                    buttonText: "Add User",
                    height: 40,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 14),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
                    )),
              ],
            ),
          ),
        ));
  }
}
