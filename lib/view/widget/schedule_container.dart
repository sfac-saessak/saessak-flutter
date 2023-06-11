import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/controller/schedule_journal/schedule_controller.dart';
import 'package:saessak_flutter/util/app_color.dart';
import 'package:saessak_flutter/util/app_text_style.dart';
import 'package:drift/drift.dart' as drift;

import '../../database/database.dart';
import 'custom_check_box.dart';
import 'custom_dialog.dart';

class ScheduleContainer extends StatelessWidget {
  const ScheduleContainer({super.key, required this.e});

  final ScheduleData e;
  @override
  Widget build(BuildContext context) {
    print(e.runtimeType);
    return Container(
      height: 60,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColor.primary70))),
      child: Row(
        children: [
          CustomCheckBox(
            e: e,
            ischecked: e.isExecuted,
            data: ScheduleCompanion(isExecuted: drift.Value(!e.isExecuted)),
          ),
          Row(
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
              // 알림 on-off 버튼
              IconButton(
                  onPressed: e.isExecuted
                      ? () {}
                      : () {
                          // 디비에 다시 저장 후 불러와 화면 리빌드하기
                          Get.find<ScheduleController>().onTapNotifyButton(
                              e,
                              ScheduleCompanion(
                                  isDoNotify: drift.Value(!e.isDoNotify)));
                        },
                  icon: e.isDoNotify
                      ? Icon(Icons.notifications,
                          color: e.isExecuted ? AppColor.black30 : null)
                      : Icon(
                          Icons.notifications_off,
                          color: AppColor.black30,
                        )),
              // 수정버튼
              IconButton(
                  onPressed: e.isExecuted
                      ? () {}
                      : () => Get.find<ScheduleController>()
                          .modifyScheduleDialog(e),
                  icon: Icon(
                    Icons.edit,
                    color: e.isExecuted ? AppColor.black30 : null,
                  )),
              // 삭제버튼
              IconButton(
                  onPressed: () {
                    Get.find<ScheduleController>().deleteSchedule(e.id);
                    Get.back();
                  },
                  icon: Icon(Icons.delete,
                      color: e.isExecuted ? AppColor.black30 : null))
            ],
          )
        ],
      ),
    );
  }
}
