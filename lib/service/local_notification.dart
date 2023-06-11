import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

class FlutterLocalNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

// init settings
  static init() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    DarwinInitializationSettings iosInitializationSettings =
        const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

// ios에 필요한 퍼미션 요청
  static requestNotificationPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  // 정해진 시간 푸쉬
  static Future showSceduledNotification(
      {required int id,
      required int year,
      required int month,
      required int day,
      required int hour,
      required int minute,
      required String plantName,
      required String content}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channelId',
      'channel name',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
    );
    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: DarwinNotificationDetails(badgeNumber: 1));
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        plantName,
        content,
        TZDateTime(getLocation('Asia/Seoul'), year, month, day, hour, minute),
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  // 예약된 push 취소
  cancelPush(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}



// // 시간 두고 푸쉬 실행
//   static Future<void> showDelayedNotification(int id) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       'channel id',
//       'channel name',
//       channelDescription: 'channel description',
//       importance: Importance.max,
//       priority: Priority.max,
//     );
//     const NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails,
//         iOS: DarwinNotificationDetails(badgeNumber: 1));
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         id,
//         '${id.toString()}',
//         '물 줘야지',
//         TZDateTime.now(getLocation('Asia/Seoul')).add(Duration(seconds: 5)),
//         notificationDetails,
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime);
//   }


// // 바로 푸쉬 실행
//   static Future<void> showNotification() async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('channel id', 'channel name',
//             channelDescription: 'channel description',
//             importance: Importance.max,
//             priority: Priority.max,
//             showWhen: false);
//     const NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails,
//         iOS: DarwinNotificationDetails(badgeNumber: 1));
//     await flutterLocalNotificationsPlugin.show(
//         0, '일정등록', '일정이 등록되었습니다.', notificationDetails);
//   }
