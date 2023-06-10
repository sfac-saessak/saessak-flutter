import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saessak_flutter/util/app_color.dart';
import 'package:saessak_flutter/util/app_text_style.dart';
import 'package:saessak_flutter/view/widget/custom_dialog.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../controller/schedule_journal/schedule_controller.dart';
import '../../widget/custom_dropdown_button.dart';
import '../../widget/resist_schedule_dialog.dart';
import '../../widget/schedule_container.dart';

class ScheduleScreen extends GetView<ScheduleController> {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Obx(
      // Rx값 변경시 전체 컬럼 리빌드. (컬럼 = 상단부 캘린더 + 하단부 선택일 일정)
      () => Column(
        children: [
          // 상단부 캘린더
          Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColor.black10),
            child: TableCalendar(
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: AppTextStyle.body2_b(),
                // leftChevronIcon: ,
                // rightChevronIcon: ,
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                  // weekendStyle: ,
                  // weekdayStyle:
                  ),
              onPageChanged: (focusedDay) {
                controller.focusedDay.value = focusedDay;
                controller.getMonthSchedule(focusedDay.month);
              },
              calendarStyle: CalendarStyle(
                defaultTextStyle: AppTextStyle.body4_b(),
                todayTextStyle: AppTextStyle.body4_b(),
                weekendTextStyle:
                    AppTextStyle.body4_b().copyWith(color: Color(0xffFF2525)),
                selectedTextStyle: AppTextStyle.body4_b(),
                markersAlignment: Alignment.bottomRight,
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, _) {
                  if (controller.monthScheduleList.value
                      .where((scdl) => scdl.day == day.day)
                      .toList()
                      .isEmpty) {
                    return null;
                  }
                  return Text(
                    controller.monthScheduleList.value
                        .where((scdl) => scdl.day == day.day)
                        .toList()
                        .length
                        .toString(),
                    style: TextStyle(color: AppColor.grey),
                  );
                },
              ),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: controller.focusedDay.value,
              locale: 'ko',
              selectedDayPredicate: (day) {
                return isSameDay(controller.selectedDay.value, day);
              },
              onDaySelected: (selectedDay, focusedDay) async {
                controller.selectedDay.value = selectedDay;
                controller.focusedDay.value = focusedDay;
              },
            ),
          ),

          // 하단부 선택일 일정 리스트뷰.
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.primary5,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('오늘의 일정',
                              style: AppTextStyle.body2_m()
                                  .copyWith(color: AppColor.black80)),
                          IconButton(
                              onPressed: () {
                                Get.dialog(ResistScheduleDialog());
                              },
                              icon: Image.asset(
                                  'assets/images/icon_material_add.png'))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColor.primary70)),
                          child: ListView(
                              children: controller.monthScheduleList.value
                                      .where((scdl) =>
                                          scdl.day ==
                                          controller.selectedDay.value.day)
                                      .toList()
                                      .isNotEmpty
                                  ? [
                                      ...controller.monthScheduleList.value
                                          .where((scdl) =>
                                              scdl.day ==
                                              controller.selectedDay.value.day)
                                          .toList()
                                          .map((e) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ScheduleContainer(e: e),
                                              ))
                                          .toList()
                                    ]
                                  : []),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ],
      ),
    ));
  }
}


