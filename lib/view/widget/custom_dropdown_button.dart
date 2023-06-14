
import 'package:flutter/material.dart';
import 'package:saessak_flutter/util/app_color.dart';
import 'package:saessak_flutter/util/app_text_style.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String? value;
  final Function(String?)? onChanged;
  final List items;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: value.runtimeType != int ? value : value.toString(),
      icon: Image.asset('assets/images/dropdown_icon.png'),
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value.runtimeType != int ? value : value.toString(),
          child: value.runtimeType != int ? Text(value, style: AppTextStyle.body4_r(color: AppColor.black30),) : Text('$value 시', style: AppTextStyle.body4_r(color: AppColor.black30)),
        );
      }).toList(),
    );
  }
}
