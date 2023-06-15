import 'package:flutter/material.dart';

import '../../util/app_color.dart';
import '../../util/app_text_style.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String)? onSubmitted;
  final TextInputType? keyboardType;

  const AppTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.onSubmitted,
      this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyle.body4_r(color: AppColor.black30),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 1),
      
      ),
      onSubmitted: onSubmitted,
    );
  }
}
