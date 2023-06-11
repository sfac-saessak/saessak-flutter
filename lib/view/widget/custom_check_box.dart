import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/schedule_journal/schedule_controller.dart';
import '../../database/database.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({super.key, this.e, required this.ischecked, this.data});

  final ScheduleData? e;
  final bool ischecked;
  final ScheduleCompanion? data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: ischecked
            ? Image.asset('assets/images/check_box_checked.png')
            : Image.asset('assets/images/check_box_empty.png'),
        onTap: () async {
          if (data != null && e != null) {
            Get.find<ScheduleController>().tapCheckBox(e!.id, data!);
          } else {
            Get.find<ScheduleController>().isDoNotify.value =
                !Get.find<ScheduleController>().isDoNotify.value;
          }
        });
  }
}
