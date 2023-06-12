import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/util/app_color.dart';
import 'package:saessak_flutter/util/app_text_style.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../controller/schedule_journal/schedule_controller.dart';
import '../../widget/resist_schedule_dialog.dart';
import '../../widget/schedule_container.dart';

class ScheduleScreen extends GetView<ScheduleController> {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.black10,
      child: Obx(
        () => Column(
      children: [
        // 상단부 캘린더
        Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColor.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.black20)),
          child: TableCalendar(
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: AppTextStyle.body2_b(),
              leftChevronIcon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColor.primary60,
              ),
              rightChevronIcon: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColor.primary60,
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: AppTextStyle.body4_b(color: Color(0xffff584e)),
                weekdayStyle: AppTextStyle.body4_b(color: AppColor.black90)),
            onPageChanged: (focusedDay) {
              controller.focusedDay.value = focusedDay;
              controller.getMonthSchedule(focusedDay.month);
            },
            calendarStyle: CalendarStyle(
              outsideTextStyle: AppTextStyle.body4_r(color: AppColor.black40),
              defaultTextStyle: AppTextStyle.body4_m(color: AppColor.black80),
              todayTextStyle: AppTextStyle.body4_m(color: AppColor.black80),
              weekendTextStyle:
                  AppTextStyle.body4_m(color: Color(0xffff584e)),
              selectedTextStyle:
                  AppTextStyle.body4_m(color: AppColor.black80),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('오늘의 일정',
                  style: AppTextStyle.body2_m()
                      .copyWith(color: AppColor.black80)),
              // 일정등록 버튼
              IconButton(
                  onPressed: () {
                    // 일정등록 다이얼로그
                    Get.dialog(ResistScheduleDialog());
                  },
                  icon: Image.asset('assets/images/icon_material_add.png')),
            ],
          ),
        ),
        // 하단부 선택일 일정 리스트뷰.
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColor.black20)),
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
      ],
        ),
      ),
    );
  }
}
