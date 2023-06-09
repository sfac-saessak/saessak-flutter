import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/controller/schedule_journal/schedule_controller.dart';
import 'package:saessak_flutter/util/app_color.dart';
import 'package:saessak_flutter/util/app_text_style.dart';
import 'package:drift/drift.dart' as drift;

import '../../database/database.dart';

class ScheduleContainer extends StatelessWidget {
  const ScheduleContainer(
      {super.key, required this.e, required this.selectedDay});

  final ScheduleData e;
  final DateTime selectedDay;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColor.black10))),
      child: Row(
        children: [
          Theme(
            data: ThemeData(
              unselectedWidgetColor: AppColor.primary, // Your color
            ),
            child: Checkbox(
              activeColor: AppColor.primary,
              value: e.isExecuted,
              onChanged: (value) {
                Get.find<ScheduleController>().tapCheckBox(e.id,
                    ScheduleCompanion(isExecuted: drift.Value(!e.isExecuted)));
              },
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '[${e.plant}]',
                    style: AppTextStyle.body2_m().copyWith(
                        color: e.isExecuted ? AppColor.black30 : null),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  e.content,
                  style: AppTextStyle.body2_m()
                      .copyWith(color: e.isExecuted ? AppColor.black30 : null),
                ),
              ],
            ),
          ),
          // 수정버튼
          if (selectedDay.day >= DateTime.now().day)
            IconButton(
                onPressed: e.isExecuted
                    ? null
                    : () =>
                        Get.find<ScheduleController>().modifyScheduleDialog(e),
                icon: Image.asset(
                  'assets/images/pencil.png',
                  color: e.isExecuted ? AppColor.black30 : null,
                )),
          // 삭제버튼
          IconButton(
              onPressed: () {
                Get.find<ScheduleController>().deleteSchedule(e.id);
                Get.back();
              },
              icon: Image.asset('assets/images/Vector (1).png'))
        ],
      ),
    );
  }
}
