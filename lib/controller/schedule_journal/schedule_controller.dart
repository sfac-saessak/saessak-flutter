import 'package:get/get.dart';

import '../../service/local_notification.dart';
import '../../view/screen/schedule_journal_screen.dart';

class ScheduleController extends GetxController {

// 임시 식물 리스트
List registeredPlantList = ['초록이', '다육이'];


// 캘린더에서 선택한 날짜
  Rx<DateTime> selectedDay = Rx(DateTime.now());



// 일정 저장되는 Map - 로컬 디바이스에 저장할 것인지, 파베에 저장할 것인지 고려해야.
  Rx<Map> events = Rx({});

  // 일정추가 - 임시구현, 단순히 events에 Event 인스턴스 추가. 임시 구현시 물주기(알림 주기 15초? 로 설정할 것임)
  addSchedule() {
    if (events.value[selectedDay.value] == null) {
      events.value[selectedDay.value] = [Event(date: selectedDay.value, plantName: '초록이',content: '물주기 - 15초 뒤 알림')];
      FlutterLocalNotification.showNotification();
      FlutterLocalNotification.showSceduledNotification();
      events.refresh();
    } else {
      events.value[selectedDay.value].add(Event(date: selectedDay.value, plantName: '초록이',content: '물주기 - 15초 뒤 알림'));
      FlutterLocalNotification.showNotification();
      FlutterLocalNotification.showSceduledNotification();
      events.refresh();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    
    FlutterLocalNotification.init();
    Future.delayed(const Duration(seconds: 3),
        FlutterLocalNotification.requestNotificationPermission());
  }
}
