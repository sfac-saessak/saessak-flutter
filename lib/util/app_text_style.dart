
import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTextStyle {
  static const thin = TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.w100);
  static const light = TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.w300);
  static const regular = TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.w400);
  static const medium = TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.w500);
  static const bold = TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.w700);
  static const black = TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.w900);

  // header
  static TextStyle header1({Color color = AppColor.black}) => bold.copyWith(fontSize: 36, color: color);
  static TextStyle header2({Color color = AppColor.black}) => bold.copyWith(fontSize: 28, color: color);
  static TextStyle header3({Color color = AppColor.black}) => bold.copyWith(fontSize: 24, color: color);
  static TextStyle header4({Color color = AppColor.black}) => bold.copyWith(fontSize: 20, color: color);

  // body
  static TextStyle body1_b({Color color = AppColor.black}) => bold.copyWith(fontSize: 18, color: color);
  static TextStyle body1_m({Color color = AppColor.black}) => medium.copyWith(fontSize: 18, color: color);
  static TextStyle body1_r({Color color = AppColor.black}) => regular.copyWith(fontSize: 18, color: color);

  static TextStyle body2_b({Color color = AppColor.black}) => bold.copyWith(fontSize: 16, color: color);
  static TextStyle body2_m({Color color = AppColor.black}) => medium.copyWith(fontSize: 16, color: color);
  static TextStyle body2_r({Color color = AppColor.black}) => regular.copyWith(fontSize: 16, color: color);

  static TextStyle body3_b({Color color = AppColor.black}) => bold.copyWith(fontSize: 14, color: color);
  static TextStyle body3_m({Color color = AppColor.black}) => medium.copyWith(fontSize: 14, color: color);
  static TextStyle body3_r({Color color = AppColor.black}) => regular.copyWith(fontSize: 14, color: color);

  static TextStyle body4_b({Color color = AppColor.black}) => bold.copyWith(fontSize: 12, color: color);
  static TextStyle body4_m({Color color = AppColor.black}) => medium.copyWith(fontSize: 12, color: color);
  static TextStyle body4_r({Color color = AppColor.black}) => regular.copyWith(fontSize: 12, color: color);

  static TextStyle body5_b({Color color = AppColor.black}) => bold.copyWith(fontSize: 10, color: color);
  static TextStyle body5_m({Color color = AppColor.black}) => medium.copyWith(fontSize: 10, color: color);
  static TextStyle body5_r({Color color = AppColor.black}) => regular.copyWith(fontSize: 10, color: color);

  // caption
  static TextStyle caption_m({Color color = AppColor.black}) => medium.copyWith(fontSize: 8, color: color);
  static TextStyle caption_r({Color color = AppColor.black}) => regular.copyWith(fontSize: 8, color: color);
}
