// custom_phone_input.dart
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class CustomPhoneTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final List<String> countries;
  final ValueChanged<PhoneNumber> onInputChanged;
  final ValueChanged<bool> onInputValidated;
  final String hintText;

  const CustomPhoneTextFormField({
    super.key,
    required this.controller,
    this.countries = const ["EG"], // Default to Egypt
    required this.onInputChanged,
    required this.onInputValidated,
    this.hintText = "Phone",
  });

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      spaceBetweenSelectorAndTextField: 0,
      initialValue: PhoneNumber(isoCode: 'HU'),
      onInputChanged: onInputChanged,
      onInputValidated: onInputValidated,
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.DIALOG,
        setSelectorButtonAsPrefixIcon: true,
        showFlags: true,
        useEmoji: true,
        useBottomSheetSafeArea: true,
        leadingPadding: 10,
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      selectorTextStyle: const TextStyle(color: Colors.black),
      textFieldController: controller,
      autofillHints: const [AutofillHints.telephoneNumber],
      inputDecoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hintText,
      ),
    );
  }
}
