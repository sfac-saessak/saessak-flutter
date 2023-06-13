import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
                headerStyle: _HeaderStyle(),
                daysOfWeekStyle: _DaysOfWeekStyle(),
                onPageChanged: (focusedDay) {
                  controller.focusedDay.value = focusedDay;
                  controller.getMonthSchedule(focusedDay.month);
                },
                calendarStyle: _CalendarStyle(),
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
                calendarBuilders: _CalendarBuilders(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      controller.selectedDay.value.day == DateTime.now().day
                          ? '오늘의 일정'
                          : '${DateFormat('M월 d일의 일정').format(controller.selectedDay.value)}',
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

  CalendarBuilders<dynamic> _CalendarBuilders() {
    return CalendarBuilders(
      defaultBuilder: (context, day, focusedDay) {
        if (day.weekday == DateTime.saturday)
          return Center(
              child: Text('${day.day}',
                  style: AppTextStyle.body4_b(color: Color(0xff1790ff))));
      },
      dowBuilder: (context, day) {
        if (day.weekday == DateTime.saturday)
          return Center(
              child: Text('토',
                  style: AppTextStyle.body4_b(color: Color(0xff1790ff))));
      },
    );
  }

  CalendarStyle _CalendarStyle() {
    return CalendarStyle(
      selectedDecoration:
          const BoxDecoration(color: AppColor.primary, shape: BoxShape.circle),
      todayDecoration: const BoxDecoration(
          color: AppColor.primary30, shape: BoxShape.circle),
      outsideTextStyle: AppTextStyle.body4_r(color: AppColor.black40),
      defaultTextStyle: AppTextStyle.body4_m(color: AppColor.black80),
      todayTextStyle: AppTextStyle.body4_m(color: AppColor.black80),
      weekendTextStyle: AppTextStyle.body4_m(color: Color(0xffff584e)),
      selectedTextStyle: AppTextStyle.body4_m(color: AppColor.white),
      markersAlignment: Alignment.bottomRight,
    );
  }

  DaysOfWeekStyle _DaysOfWeekStyle() {
    return DaysOfWeekStyle(
        weekendStyle: AppTextStyle.body4_b(color: Color(0xffff584e)),
        weekdayStyle: AppTextStyle.body4_b(color: AppColor.black90));
  }

  HeaderStyle _HeaderStyle() {
    return HeaderStyle(
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
    );
  }
}
