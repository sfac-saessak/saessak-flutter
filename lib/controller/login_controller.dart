import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../util/app_routes.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  RxnString emailErrorText = RxnString(); // 이메일 입력란 에러메세지
  RxnString pwErrorText = RxnString(); // 비밀번호 입력란 에러메세지
   RxBool isValidLogin = false.obs; // 로그인 버튼 활성화 위한 bool

  login() {
    AuthController().login(emailController.text, pwController.text);
  }

  signup() => Get.toNamed(AppRoutes.signup);
  resetPassWord() => Get.toNamed(AppRoutes.resetPassword);

  signInWithGoogle() => AuthController().signInWithGoogle();

 
  onChanged() {
    if (emailController.text != null &&
        !emailController.text.isEmpty &&
        pwController.text != null &&
        !pwController.text.isEmpty) {
      isValidLogin.value = true;
    } else {
      isValidLogin.value = false;
    }
  }
}
