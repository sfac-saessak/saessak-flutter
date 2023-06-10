import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/controller/schedule_journal/schedule_controller.dart';
import 'package:saessak_flutter/util/app_color.dart';
import 'package:saessak_flutter/util/app_text_style.dart';
import 'package:drift/drift.dart' as drift;
import 'package:saessak_flutter/view/screen/shcedule_journal/schedule_screen.dart';
import 'package:saessak_flutter/view/widget/resist_schedule_dialog.dart';

import '../../database/database.dart';
import 'custom_dialog.dart';

class ScheduleContainer extends StatelessWidget {
  const ScheduleContainer({super.key, required this.e});

  final ScheduleData e;
  final String unChecked = 'assets/images/check_box_empty.png';
  final String checked = 'assets/images/check_box_checked.png';
  @override
  Widget build(BuildContext context) {
    print(e.runtimeType);
    return Container(
      height: 60,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColor.primary70))),
      child: Row(
        children: [
          GestureDetector(
              child:
                  e.isExecuted ? Image.asset(checked) : Image.asset(unChecked),
              onTap: () async {
                print(e);
                Get.find<ScheduleController>().tapCheckBox(e.id,
                    ScheduleCompanion(isExecuted: drift.Value(!e.isExecuted)));
              }),
          GestureDetector(
            onTap: () => Get.dialog(
              CustomDialog(
                child: Column(children: [
                  Text('이름: ${e.plant}'),
                  Text('날짜: ${e.year}년 ${e.month}월 ${e.day}일'),
                  Text('시간: ${e.time} 시'),
                  Text('내용: ${e.content}'),
                ]),
                leftButtonText: '일정수정',
                rightButtonText: '일정삭제',
                leftButtonOnTap: () => Get.find<ScheduleController>().modifyScheduleDialog(e),
                rightButtonOnTap: () {
                  Get.find<ScheduleController>().deleteSchedule(e.id);
                  Get.back();
                },
              ),
            ),
            child: Row(
              children: [
                Text(
                  '[${e.plant}]',
                  style: AppTextStyle.body2_m()
                      .copyWith(color: e.isExecuted ? AppColor.black30 : null),
                ),
                Text(
                  e.content,
                  style: AppTextStyle.body2_m()
                      .copyWith(color: e.isExecuted ? AppColor.black30 : null),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
