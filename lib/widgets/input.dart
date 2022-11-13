import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lefoode/constants/colors.dart';
import 'package:lefoode/widgets/v_space.dart';

class Input extends StatelessWidget {
  final String? hintText;
  final Iterable<String>? autofillHints;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final bool nextInputAvailable;
  final int? maxLength;
  final void Function(String)? onChanged;
  final String? labelText;
  final bool autofocus;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? headerText;
  final bool noBorders;
  final bool readOnly;
  const Input({
    Key? key,
    this.controller,
    this.keyboardType,
    this.autofillHints,
    this.hintText,
    this.validator,
    this.maxLength,
    this.nextInputAvailable = false,
    this.onChanged,
    this.labelText,
    this.autofocus = false,
    this.prefixIcon,
    this.suffixIcon,
    this.headerText,
    this.noBorders = false,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formField = TextFormField(
      style: TextStyle(
        fontSize: 16,
      ),
      autofocus: autofocus,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      autofillHints: autofillHints,
      enableSuggestions: true,
      maxLength: maxLength,
      textInputAction:
          nextInputAvailable ? TextInputAction.next : TextInputAction.done,
      maxLengthEnforcement: maxLength != null
          ? MaxLengthEnforcement.enforced
          : MaxLengthEnforcement.none,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        prefixIconColor: Colors.grey,
        labelStyle: const TextStyle(
          color: Color(0xffCF2A6F),
        ),
      ),
    );
    if (headerText != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headerText!,
            style: const TextStyle(
              fontSize: 18,
              color: ConstantColors.lighterGrayText,
            ),
          ),
          const VSpace(s: 8),
          formField,
        ],
      );
    }
    return formField;
  }
}
