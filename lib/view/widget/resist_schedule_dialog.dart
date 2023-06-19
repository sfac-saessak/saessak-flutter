import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saessak_flutter/util/app_color.dart';
import 'package:saessak_flutter/util/app_text_style.dart';

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
          () => Padding(
            padding: const EdgeInsets.all(30.0),
            child: Wrap(children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '이름',
                        style: AppTextStyle.body3_m(color: AppColor.black80),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      // 등록식물 선택 드롭박스
                      Expanded(
                        child: CustomDropDownButton(
                            value: controller.plantDropdownValue.value,
                            items: controller.plantList,
                            onChanged: (String? value) {
                              controller.plantDropdownValue.value = value!;
                            }),
                      )
                    ],
                  ),

                  // 날짜 표시
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '날짜',
                        style: AppTextStyle.body3_m(color: AppColor.black80),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          '${DateFormat('yyyy년 M월 d일').format(controller.selectedDay.value)}',
                          style:
                              AppTextStyle.body4_m(color: AppColor.primary),
                        ),
                      ),
                    ],
                  ),

                  // 시간 선택 드롭박스
                  Row(
                    children: [
                      Text(
                        '시간',
                        style: AppTextStyle.body3_m(color: AppColor.black80),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomDropDownButton(
                            value:
                                controller.timeDropdownValue.value.toString(),
                            items: controller.selectTimeList,
                            onChanged: (String? value) {
                              controller.timeDropdownValue.value = value!;
                            }),
                      ),
                    ],
                  ),

                  // 일정 종류 선택 드롭박스
                  Row(
                    children: [
                      Text(
                        '일정',
                        style: AppTextStyle.body3_m(color: AppColor.black80),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomDropDownButton(
                            value: controller.eventDropdownValue.value,
                            items: controller.eventList,
                            onChanged: (String? value) {
                              controller.eventDropdownValue.value = value!;
                            }),
                      ),
                    ],
                  ),

                  // 알림설정 스위치
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '알림',
                        style: AppTextStyle.body3_m(color: AppColor.black80),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Transform.scale(
                        scale: 0.8,
                        child: Switch.adaptive(
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          activeColor: AppColor.primary,
                          value: controller.isDoNotify.value,
                          onChanged: (value) =>
                              controller.isDoNotify.value = value,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ),
        leftButtonOnTap: () => Get.back(),
        rightButtonOnTap: () async {
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
