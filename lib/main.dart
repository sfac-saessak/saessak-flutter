import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'controller/plant/plant_detail_controller.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'controller/challenge/challenge_controller.dart';
import 'controller/challenge/chat_controller.dart';
import 'controller/community/community_controller.dart';
import 'controller/follow/friends_list_controller.dart';
import 'controller/follow/friend_detail_controller.dart';
import 'controller/follow/friends_controller.dart';
import 'controller/plant/plant_controller.dart';
import 'controller/reset_password_controller.dart';
import 'controller/schedule_journal/journal_controller.dart';
import 'controller/schedule_journal/schedule_controller.dart';
import 'controller/schedule_journal/schedule_journal_main_controller.dart';
import 'controller/setting_controller.dart';
import 'controller/auth_controller.dart';
import 'controller/login_controller.dart';
import 'controller/set_profile_controller.dart';
import 'controller/signup_controller.dart';
import 'controller/main_controller.dart';
import 'util/app_pages.dart';
import 'util/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'NotoSansKR'),
          initialBinding: BindingsBuilder(() {
            Get.put(AuthController());
            Get.lazyPut(() => LoginController(), fenix: true);
            Get.lazyPut(() => SignupController(), fenix: true);
            Get.lazyPut(() => SetProfileController(), fenix: true);
            Get.lazyPut(() => MainController(), fenix: true);
            Get.lazyPut(() => CommunityController(), fenix: true);
            Get.lazyPut(() => ScheduleController(), fenix: true);
            Get.lazyPut(() => ChallengeController(), fenix: true);
            Get.lazyPut(() => ChatController(), fenix: true);
            Get.lazyPut(() => ResetPasswordController(), fenix: true);
            Get.lazyPut(() => PlantController(), fenix: true);
            Get.lazyPut(() => FriendsController(), fenix: true);
            Get.lazyPut(() => ScheduleJornalMainController(), fenix: true);
            Get.lazyPut(() => FriendDetailController(), fenix: true);
            Get.lazyPut(() => JournalController(), fenix: true);
            Get.lazyPut(() => SettingController(), fenix: true);
            Get.lazyPut(() => FriendsListController(), fenix: true);
            Get.lazyPut(() => PlantDetailController(), fenix: true);
          }),
          getPages: AppPages.pages,
          initialRoute: AppRoutes.splash,
        );
      },
    );
  }
}
