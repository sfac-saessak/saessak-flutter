import 'package:get/get.dart';
import 'package:saessak_flutter/view/page/reset_password_page.dart';
import 'package:saessak_flutter/view/screen/splash_screen.dart';

import '../view/page/challenge/chat_page.dart';
import '../view/page/login_page.dart';
import '../view/page/main_page.dart';
import '../view/page/set_profile_page.dart';
import '../view/page/signup_page.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: MainPage.route,
        page: () => const MainPage(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500)),
    GetPage(name: LoginPage.route, page: () => const LoginPage()),
    GetPage(name: SignupPage.route, page: () => const SignupPage()),
    GetPage(name: SetProfilePage.route, page: () => const SetProfilePage()),
    GetPage(
        name: Splash.route,
        page: () => const Splash(),
        transition: Transition.noTransition),
    GetPage(name: ChatPage.route, page: () => const ChatPage()),
    GetPage(
        name: ResetPasswordPage.route, page: () => const ResetPasswordPage())
  ];
}
