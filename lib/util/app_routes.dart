import 'package:saessak_flutter/view/screen/splash_screen.dart';

import '../view/page/challenge/chat_page.dart';
import '../view/page/login_page.dart';
import '../view/page/set_profile_page.dart';
import '../view/page/signup_page.dart';
import '../view/page/main_page.dart';

class AppRoutes {
  static const login = LoginPage.route;
  static const main = MainPage.route;
  static const signup = SignupPage.route;
  static const setName = SetProfilePage.route;
  static const splash = Splash.route;
  static const chat = ChatPage.route;
}
