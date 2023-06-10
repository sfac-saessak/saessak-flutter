import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/schedule_journal/schedule_controller.dart';
import '../../database/database.dart';
import 'custom_dialog.dart';
import 'custom_dropdown_button.dart';

class ResistScheduleDialog extends GetView<ScheduleController> {
  const ResistScheduleDialog({super.key, this.e});

  final ScheduleData? e;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
        leftButtonText: '취소',
        rightButtonText: '등록',
        child: Obx(
          () => Column(
            children: [
              CustomDropDownButton(
                  value: controller.plantDropdownValue.value,
                  items: controller.registeredPlantList,
                  onChanged: (String? value) {
                    controller.plantDropdownValue.value = value!;
                  }),
              Text(
                  '날짜: ${DateFormat('yyyy년 M월 d일').format(controller.selectedDay.value)}'),
              CustomDropDownButton(
                  value: controller.timeDropdownValue.value.toString(),
                  items: controller.selectTimeList,
                  onChanged: (String? value) {
                    controller.timeDropdownValue.value = value!;
                  }),
              CustomDropDownButton(
                  value: controller.eventDropdownValue.value,
                  items: controller.eventList,
                  onChanged: (String? value) {
                    controller.eventDropdownValue.value = value!;
                  }),
            ],
          ),
        ),
        leftButtonOnTap: () => Get.back(),
        rightButtonOnTap: () {
          if (e != null) {
            controller.modifySchedule(e!);
            Get.back();
          } else {
            controller.addSchedule();
            Get.back();
          }
        });
  }
}
