import 'package:flutter/material.dart';
import '../../../../../shared/style/colors_manager.dart';
import '../../model/drop_down_model.dart';

class CustomDropdownButton extends StatefulWidget {
  final String hint;
  final String? value; // Kept as String? for DropdownMenu<String?>
  final List<DropDownModel?> items; // List of DropDownModel?
  final ValueChanged<String?> onChanged; // Changed to String?
  final double? radius;
  final FormFieldValidator<String>? validator;

  const CustomDropdownButton({
    Key? key,
    required this.hint,
    required this.value,
    this.radius,
    required this.items,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen height
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate dynamic menu height as a percentage of the screen height
    double menuHeight = widget.items.length > 5
        ? screenHeight * 0.4
        : widget.items.length * 60.0; // Maximum height for long lists

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: DropdownMenu<String?>(

        initialSelection: widget.value,
        width: double.infinity,
        hintText: widget.hint,
        requestFocusOnTap: false, // Do not request focus on tap
        enableSearch: false, // Disable search

        menuStyle: MenuStyle(
          padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 25)),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          )),
        ),
        menuHeight: menuHeight, // Set dynamic menu height based on screen size
        inputDecorationTheme: InputDecorationTheme(
          alignLabelWithHint: false,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintStyle:  const TextStyle(
            color: ColorManagerHelper.kGreyColor,
            fontSize: 11,
          ),
          labelStyle: const TextStyle(
            color: ColorManagerHelper.kGreyColor,
            fontSize: 13.5,
          ),
          filled: true,
          fillColor: Colors.blueGrey.withOpacity(0.055),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.blueGrey.withOpacity(0.030),
            ),
            gapPadding: 5,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.blueGrey.withOpacity(0.030),
            ),
            gapPadding: 5,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.blueGrey.withOpacity(0.030),
            ),
            gapPadding: 5,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.blueGrey.withOpacity(0.030),
            ),
            gapPadding: 5,
          ),
        ),
        label: Text(widget.hint, style: const TextStyle(fontSize: 11)),
        textStyle: const TextStyle(fontSize: 11),

        onSelected: (value) {
          widget.onChanged(value); // Notify parent of the selection
          FocusScope.of(context).unfocus(); // Dismiss the keyboard
        },
        dropdownMenuEntries: widget.items.map<DropdownMenuEntry<String?>>((DropDownModel? item) {
          return DropdownMenuEntry<String?>(
            value: item?.id, // Use item?.id as the value
            label: item?.name ?? '',
          );
        }).toList(),
      ),
    );
  }
}
