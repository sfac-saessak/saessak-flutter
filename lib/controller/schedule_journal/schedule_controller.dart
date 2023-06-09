import 'package:get/get.dart';
import 'package:saessak_flutter/database/database.dart';
import 'package:drift/drift.dart' as drift;
import '../../service/local_notification.dart';

class ScheduleController extends GetxController {
  final localDb = LocalDatabase();

// 식물선택 드롭다운 밸류
  RxString plantDropdownValue = RxString('등록식물');
  // 시간선택 드롭다운 밸류
  RxString timeDropdownValue = RxString('18');
  // 일정선택 드롭다운 밸류
  RxString eventDropdownValue = RxString('일정 종류');

// 임시 식물 리스트
  List<String> registeredPlantList = <String>['등록식물', '초록이', '다육이'];
// 시간 리스트
  List<int> selectTimeList = List<int>.generate(24, (int index) => index);
  // 일정 리스트
  List<String> eventList = <String>['일정 종류', '급수', '분갈이', '영양제투여', '수분', '수확'];

// 월단위 일정 리스트
  Rx<List> monthScheduleList = Rx([]);

// 캘린더에서 선택한 날짜
  Rx<DateTime> selectedDay = Rx(DateTime.now());
  Rx<DateTime> focusedDay = Rx(DateTime.now());

// 일정 저장되는 Map - 로컬 디바이스에 저장할 것인지, 파베에 저장할 것인지 고려해야.
  Rx<Map> events = Rx({});

// 일정추가 - 임시구현, 단순히 events에 Event 인스턴스 추가. 임시 구현시 물주기(알림 주기 15초? 로 설정할 것임)
  addSchedule() async {
  // 디비에 추가
    await localDb.createSchedule(
      ScheduleCompanion(
        year: drift.Value(selectedDay.value.year),
        month: drift.Value(selectedDay.value.month),
        day: drift.Value(selectedDay.value.day),
        plant: drift.Value(plantDropdownValue.value),
        isExecuted: drift.Value(false),
        content: drift.Value(eventDropdownValue.value),
        time: drift.Value(int.parse(timeDropdownValue.value)),
      ),
    );
    getMonthSchedule(selectedDay.value.month); // 추가된 데이터 포함된 전체 데이터 가져오기
  }

  // 월단위 일정 가져오기
  getMonthSchedule(month) async {
    monthScheduleList.value = await localDb.selectMonthSchedule(month);
  }

  // 일정 삭제
  deleteSchedule(int id) async {
    await localDb.deleteSchedule(id);
    getMonthSchedule(selectedDay.value.month);
  }

  // 일정 수정 - 구현 예정

  // 체크박스 누르기(일정 수정)
  tapCheckBox(int id, ScheduleCompanion data) async {
    await localDb.updateIsExecuted(id, data); // 체크 여부 db에 업데이트
    getMonthSchedule(selectedDay.value.month); // 업데이트 반영된 전체일정 가져오기
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMonthSchedule(selectedDay.value.month); // 일정 탭 선택시 월단위 일정 가져오기
    FlutterLocalNotification.init();
    Future.delayed(const Duration(seconds: 3),
        FlutterLocalNotification.requestNotificationPermission());
  }
}


    // // 예시 푸쉬알림
    // if (events.value[selectedDay.value] == null) {
    //   events.value[selectedDay.value] = [
    //     Event(
    //         date: selectedDay.value,
    //         plantName: '초록이',
    //         content: '물주기 - 15초 뒤 알림')
    //   ];
    //   FlutterLocalNotification.showNotification();
    //   FlutterLocalNotification.showSceduledNotification();
    //   events.refresh();
    // } else {
    //   events.value[selectedDay.value].add(Event(
    //       date: selectedDay.value,
    //       plantName: '초록이',
    //       content: '물주기 - 15초 뒤 알림'));
    //   FlutterLocalNotification.showNotification();
    //   FlutterLocalNotification.showSceduledNotification();
    //   events.refresh();
    // }