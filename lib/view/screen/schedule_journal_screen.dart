import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/controller/schedule_journal/schedule_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleJournalScreen extends GetView<ScheduleController> {
  const ScheduleJournalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Obx( // Rx값 변경시 전체 컬럼 리빌드. (컬럼 = 상단부 캘린더 + 하단부 선택일 일정)
      () => Column(
        children: [

          // 상단부 캘린더
          TableCalendar(
            calendarStyle: CalendarStyle(
              markersAlignment: Alignment.bottomRight,
            ),
            calendarBuilders: CalendarBuilders(

              // 일정 있는 날에 표시되는 마커
              markerBuilder: (context, day, _) {
                // 일정은 controller의 events에 <Map<DateTime, List>>의 형태로 저장하고 있음
                // 해당일에 일정이 있다면 마커가 표시됨.
                return controller.events.value[day] != null 
                    ? Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.bottomRight,
                        decoration: const BoxDecoration(
                          color: Colors.lightBlue,
                        ),
                        child: Text(
                          '${controller.events.value[day].length}', // 마커 안에 표시되는 내용. 일정의 수
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    : null;
              },
            ),
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            locale: 'ko',
            selectedDayPredicate: (day) {
              return isSameDay(controller.selectedDay.value, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              controller.selectedDay.value = selectedDay;
            },
          ),

          // 임시로 구현한 일정추가 버튼
          TextButton(
              onPressed: () {
                controller.addSchedule();
              },
              child: Text('일정추가')),


          // 하단부 선택일 일정 리스트뷰.    
          Expanded(
            child: ListView(
                children: controller
                            .events.value[controller.selectedDay.value] !=
                        null
                    ? [
                        ...controller.events.value[controller.selectedDay.value]
                            .map((e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container( // 임시 구현. 일정 하나에 컨테이너 하나씩
                                    height: 20,
                                    width: 50,
                                    color: Colors.black,
                                  ),
                            ))
                            .toList()
                      ]
                    : []),
          )
        ],
      ),
    ));
  }
}

class Event {
  String title;

  Event(this.title);
}
