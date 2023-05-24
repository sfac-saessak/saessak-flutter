import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

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
      }),
      getPages: AppPages.pages,
      initialRoute: AppRoutes.login,
    );
  }
}
