
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../util/app_color.dart';
import '../../util/app_text_style.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    super.key,
    required this.text
  });

final String text;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(text, style: AppTextStyle.header4(color: AppColor.white),),SizedBox(height: 20,), LoadingWidget()]),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Pulse(
      infinite: true,
      child: Image.asset('assets/images/logo.png', height: 50,));
  }
}
