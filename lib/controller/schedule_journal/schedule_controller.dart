import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/database/database.dart';
import 'package:drift/drift.dart' as drift;
import '../../model/plant.dart';
import '../../service/db_service.dart';
import '../../service/local_notification.dart';
import '../../view/widget/resist_schedule_dialog.dart';

class ScheduleController extends GetxController {
  final localDb = LocalDatabase();
  User user = FirebaseAuth.instance.currentUser!;

  RxString plantDropdownValue = RxString('등록식물'); // 식물선택 드롭다운 밸류
  RxString timeDropdownValue = RxString('18'); // 시간선택 드롭다운 밸류
  RxString eventDropdownValue = RxString('일정 종류'); // 일정선택 드롭다운 밸류
  RxList<String> plantList = <String>['등록식물'].obs; // 식물 리스트
  List<int> selectTimeList =
      List<int>.generate(24, (int index) => index); // 시간 리스트
  List<String> eventList = <String>[
    '일정 종류',
    '급수',
    '분갈이',
    '영양제투여',
    '수분',
    '수확'
  ]; // 일정 리스트
  RxBool isDoNotify = RxBool(false); // 알림 여부
  Rx<List> monthScheduleList = Rx([]); // 월단위 일정 리스트
  Rx<DateTime> selectedDay = Rx(DateTime.now()); // 캘린더 선택 날짜
  Rx<DateTime> focusedDay = Rx(DateTime.now()); // 캘린더 포커스 날짜

  // 식물 가져오기
  getPlants() async {
    QuerySnapshot snapshot = await DBService(uid: user.uid).getPlants();
    plantList.addAll(snapshot.docs
        .map((doc) => Plant.fromMap(doc.data() as Map<String, dynamic>).name)
        .toList());
  }

// 일정추가 - 임시구현, 단순히 events에 Event 인스턴스 추가. 임시 구현시 물주기(알림 주기 15초? 로 설정할 것임)
  addSchedule() async {
    // 디비에 추가
    int id = await localDb.createSchedule(
      ScheduleCompanion(
          year: drift.Value(selectedDay.value.year),
          month: drift.Value(selectedDay.value.month),
          day: drift.Value(selectedDay.value.day),
          plant: drift.Value(plantDropdownValue.value),
          isExecuted: drift.Value(false),
          content: drift.Value(eventDropdownValue.value),
          time: drift.Value(int.parse(timeDropdownValue.value)),
          userUid: drift.Value(user.uid),
          isDoNotify: drift.Value(isDoNotify.value)),
    );
    getMonthSchedule(selectedDay.value.month); // 추가된 데이터 포함된 전체 데이터 가져오기
    if (isDoNotify.value) {
      reservePush(id: id);
    }
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

  // 일정 수정 다이얼로그 띄우기
  modifyScheduleDialog(ScheduleData e) {
    if (plantList.contains(e.plant)) {
      plantDropdownValue.value = e.plant;
      timeDropdownValue.value = e.time.toString();
      eventDropdownValue.value = e.content;
      isDoNotify.value = e.isDoNotify;
      Get.dialog(ResistScheduleDialog(e: e));
    } else {
      Get.snackbar('수정할 수 없습니다.', '삭제된 식물입니다.');
    }
  }

  // 일정 수정
  modifySchedule(ScheduleData e) async {
    await localDb.updateSchedule(
      e.id,
      ScheduleCompanion(
          year: drift.Value(selectedDay.value.year),
          month: drift.Value(selectedDay.value.month),
          day: drift.Value(selectedDay.value.day),
          plant: drift.Value(plantDropdownValue.value),
          content: drift.Value(eventDropdownValue.value),
          time: drift.Value(int.parse(timeDropdownValue.value)),
          isDoNotify: drift.Value(isDoNotify.value)),
    );
    getMonthSchedule(selectedDay.value.month); // 수정된 데이터로 다시 데이터 가져오기
    cancelPush(e.id); // 기존 푸쉬 예약 취소
    if (isDoNotify.value) {
      reservePush(id: e.id); // 다시 푸쉬 예약
    }
  }

  // 체크박스 누르기(일정 수정)
  tapCheckBox(int id, ScheduleCompanion data) async {
    await localDb.updateSchedule(id, data); // 체크 여부 db에 업데이트
    getMonthSchedule(selectedDay.value.month); // 업데이트 반영된 전체일정 가져오기
  }

  onTapNotifyButton(ScheduleData e, ScheduleCompanion data) async {
    if (e.isDoNotify) {
      // cancle push
      await localDb.updateSchedule(e.id, data);
      cancelPush(e.id);
    } else {
      // reserve push
      await localDb.updateSchedule(e.id, data);
      reservePush(id: e.id);
    }
    getMonthSchedule(selectedDay.value.month); // 업데이트 반영된 전체일정 가져오기
  }

  // 푸쉬 예약
  reservePush({
    required int id,
  }) async {
    await FlutterLocalNotification.showSceduledNotification(
        id: id,
        year: selectedDay.value.year,
        month: selectedDay.value.month,
        day: selectedDay.value.day,
        hour: int.parse(timeDropdownValue.value),
        plantName: plantDropdownValue.value,
        content: eventDropdownValue.value,
        minute: 00);
    print('알림 예약 완료, id: $id');
  }

  // 푸쉬 취소
  cancelPush(int id) async {
    await FlutterLocalNotification().cancelPush(id);
    print('알림 취소 완료, id: $id');
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPlants();
    getMonthSchedule(focusedDay.value.month); // 일정 탭 선택시 월단위 일정 가져오기
    FlutterLocalNotification.init();
    Future.delayed(const Duration(seconds: 3),
        FlutterLocalNotification.requestNotificationPermission());
  }
}
