
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class SignupController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController pwConfirmController = TextEditingController();

  signUp() {
    String email = emailController.text.trim();
    String password = pwController.text.trim();
    String passwordConfirm = pwConfirmController.text.trim();

    if (!isEmailValid(email)) {
      // 이메일이 올바른 형식이 아닌 경우
      snackBar('이메일이 비어있거나 올바른 형식이 아닙니다.');
      return;
    }

    if (password.length < 9) {
      // 비밀번호가 9자 미만인 경우
      snackBar('비밀번호가 비어있거나 9글자 미만입니다.');
      return;
    }

    if (password != passwordConfirm) {
      // 비밀번호와 비밀번호 확인이 일치하지 않는 경우
      snackBar('비밀번호가 일치하지 않습니다.');
      return;
    }

    AuthController().signup(email, password);
    Get.snackbar('회원가입 성공!', '성공적으로 계정을 생성했습니다.');
    return;
  }

  bool isEmailValid(String email) {
    // 이메일 형식이 올바른지 확인하는 정규식
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  void snackBar(String message) {
    Get.snackbar('회원가입 실패', message);
  }
}
