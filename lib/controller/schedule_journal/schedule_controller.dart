import 'package:get/get.dart';

import '../../view/screen/schedule_journal_screen.dart';

class ScheduleController extends GetxController {
  Rx<DateTime> selectedDay = Rx(DateTime.now());

// 일정 저장되는 Map - 로컬 디바이스에 저장할 것인지, 파베에 저장할 것인지 고려해야.
  Rx<Map> events = Rx({});

  // 일정추가 - 임시구현, 단순히 events에 Event 인스턴스 추가. 임시 구현시 물주기(알림 주기 15초? 로 설정할 것임)
  addSchedule() {
    if (events.value[selectedDay.value] == null) {
      events.value[selectedDay.value] = [Event('title')];
      events.refresh();
    } else {
      events.value[selectedDay.value].add(Event('title'));
      events.refresh();
    }
  }
}
