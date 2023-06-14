import 'package:flutter/material.dart';

import '../../util/app_color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.isenableButton,
      this.textStyle});

  final VoidCallback onPressed;
  final String text;
  final bool isenableButton;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            disabledBackgroundColor: AppColor.lightGrey,
            backgroundColor: AppColor.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0),
        onPressed: isenableButton ? onPressed : null,
        child: Text(
          text,
          style: textStyle ?? null,
        ),
      ),
    );
  }
}
