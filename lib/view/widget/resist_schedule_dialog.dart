import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saessak_flutter/view/widget/custom_check_box.dart';

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
              // 등록식물 선택 드롭박스
              CustomDropDownButton(
                  value: controller.plantDropdownValue.value,
                  items: controller.registeredPlantList,
                  onChanged: (String? value) {
                    controller.plantDropdownValue.value = value!;
                  }),

              // 날짜 표시
              Text(
                  '날짜: ${DateFormat('yyyy년 M월 d일').format(controller.selectedDay.value)}'),

              // 시간 선택 드롭박스
              CustomDropDownButton(
                  value: controller.timeDropdownValue.value.toString(),
                  items: controller.selectTimeList,
                  onChanged: (String? value) {
                    controller.timeDropdownValue.value = value!;
                  }),

              // 일정 종류 선택 드롭박스
              CustomDropDownButton(
                  value: controller.eventDropdownValue.value,
                  items: controller.eventList,
                  onChanged: (String? value) {
                    controller.eventDropdownValue.value = value!;
                  }),

              // 알림설정 체크박스
              if (e == null)
                Row(
                  children: [
                    Text('알림 설정'),
                    CustomCheckBox(ischecked: controller.isDoNotify.value)
                  ],
                )
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
