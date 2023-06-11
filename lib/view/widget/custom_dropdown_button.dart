
import 'package:flutter/material.dart';

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
      value: value.runtimeType != int ? value : value.toString(),
      icon: const Icon(Icons.arrow_downward),
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value.runtimeType != int ? value : value.toString(),
          child: value.runtimeType != int ? Text(value) : Text('$value 시'),
        );
      }).toList(),
    );
  }
}
