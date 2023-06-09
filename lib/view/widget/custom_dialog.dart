import 'package:flutter/material.dart';
import '../../database/database.dart';
import '../../util/app_color.dart';
import '../../util/app_text_style.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog(
      {super.key,
      required this.e,
      required this.leftButtonText,
      required this.rightButtonText,
      required this.child,
      required this.leftButtonOnTap,
      required this.rightButtonOnTap});

  final ScheduleData e;
  final Widget child;
  final String leftButtonText;
  final String rightButtonText;
  final VoidCallback leftButtonOnTap;
  final VoidCallback rightButtonOnTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            child,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                      onTap: leftButtonOnTap,
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: AppColor.primary10,
                            border: Border.all(color: AppColor.primary80),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(4))),
                        child: Center(
                            child: Text(leftButtonText,
                                style: AppTextStyle.body4_m().copyWith(
                                  color: AppColor.primary,
                                ))),
                      )),
                ),
                Expanded(
                  child: GestureDetector(
                      onTap: rightButtonOnTap,
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: AppColor.primary10,
                            border: Border.all(color: AppColor.primary80),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(4))),
                        child: Center(
                            child: Text(rightButtonText,
                                style: AppTextStyle.body4_m().copyWith(
                                  color: AppColor.primary,
                                ))),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
