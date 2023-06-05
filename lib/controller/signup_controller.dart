import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class SignupController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController pwConfirmController = TextEditingController();
  RxnString emailErrorText = RxnString(); // 이메일 입력란 에러메세지
  RxnString pwErrorText = RxnString(); // 비밀번호 입력란 에러메세지
  RxnString pwConfirmErrorText = RxnString(); // 비밀번호 입력란 에러메세지
  RxBool isValidSignUp = false.obs; // 회원가입 버튼 활성화 위한 bool

  // 이메일 입력란 onChanged 함수
  emailOnChanged() {
    if (emailController.text.isNotEmpty &&
        !isEmailValid(emailController.text)) {
      emailErrorText.value = '이메일이 올바른 형식이 아닙니다.';
      enableButton();
    } else {
      emailErrorText.value = null;
      enableButton();
    }
  }

  // 비번 입력란 onChanged 함수
  pwOnChanged() {
    if (pwController.text.isNotEmpty && pwController.text.length < 9) {
      pwErrorText.value = '비밀번호가 9글자 미만입니다';
      enableButton();
    } else {
      pwErrorText.value = null;
      enableButton();
    }
  }

  // 비번확인 입력란 onChanged 함수
  pwConfirmOnChanged() {
    if (pwConfirmController.text.isNotEmpty &&
        pwConfirmController.text != pwController.text) {
      pwConfirmErrorText.value = '비밀번호가 일치하지 않습니다.';
      enableButton();
    } else {
      pwConfirmErrorText.value = null;
      enableButton();
    }
  }

  enableButton() {
    if (emailErrorText.value == null &&
        pwErrorText.value == null &&
        pwConfirmErrorText.value == null) {
      isValidSignUp.value = true;
    } else {
      isValidSignUp.value = false;
    }
  }

  signUp() {
    String email = emailController.text.trim();
    String password = pwController.text.trim();
    String passwordConfirm = pwConfirmController.text.trim();
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
