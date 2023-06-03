import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:saessak_flutter/controller/community/community_controller.dart';
import 'package:saessak_flutter/controller/schedule_journal/schedule_controller.dart';
import 'package:saessak_flutter/view/screen/splash_screen.dart';
import 'controller/challenge/challenge_controller.dart';
import 'controller/challenge/chat_controller.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;

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
    return GetMaterialApp(
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
      }),
      getPages: AppPages.pages,
      initialRoute: AppRoutes.splash,
    );
  }
}
