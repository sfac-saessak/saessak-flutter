import 'package:flutter/material.dart';

import '../../util/app_color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.suffixIcon,
      this.onChanged,
      this.errorText,
      this.formKey,
      this.validator});

  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final dynamic onChanged;
  final String? errorText;
  final GlobalKey<FormState>? formKey;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: formKey ?? null,
      validator: validator,
      controller: controller,
      onChanged: (value) {
        onChanged() ?? null;
      },
      decoration: InputDecoration(
          hintText: hintText,
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffFF2525), width: 2),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffFF2525), width: 2),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          errorText: errorText ?? null,
          errorStyle: TextStyle(color: Color(0xffFF2525)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.lightGrey, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: AppColor.grey),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          suffixIcon: suffixIcon ?? null),
    );
  }
}
