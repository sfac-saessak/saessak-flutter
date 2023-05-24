
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../util/app_routes.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  login() => AuthController().login(emailController.text, pwController.text);

  signup() => Get.toNamed(AppRoutes.signup);

  signInWithGoogle() => AuthController().signInWithGoogle();
}
