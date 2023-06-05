import 'package:flutter/material.dart';

import '../../util/app_color.dart';
import '../../util/app_text_style.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String)? onSubmitted;

  const AppTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyle.body3_r(color: AppColor.grey),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
      ),
      onSubmitted: onSubmitted,
    );
  }
}
