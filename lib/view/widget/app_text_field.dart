import 'package:flutter/material.dart';

import '../../util/app_color.dart';
import '../../util/app_text_style.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String)? onSubmitted;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;

  const AppTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.onSubmitted,
      this.keyboardType,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.black20)),
        hintText: hintText,
        hintStyle: AppTextStyle.body3_m(color: AppColor.black30),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.black20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 1),
      ),
      onSubmitted: onSubmitted,
      style: textStyle ?? null,
    );
  }
}
