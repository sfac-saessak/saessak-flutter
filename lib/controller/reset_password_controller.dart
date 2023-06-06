import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/controller/auth_controller.dart';

class ResetPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  RxnString emailErrorText = RxnString(); // 이메일 입력란 에러메세지
  RxBool isEnableButton = false.obs; // 버튼 활성화 위한 bool

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

  enableButton() {
    if (emailErrorText.value == null && emailController.text != '' ) {
      isEnableButton.value = true;
    } else {
      isEnableButton.value = false;
    }
  }

  // 비밀번호 재설정 메일 발송
  sendResetPasswordEmail () {
    AuthController().sendResetPasswordEmail(emailController.text.trim());
    Get.rawSnackbar(
            title: '입력한 이메일로 비밀번호 재설정 메일을 발송하였습니다.',
            message: '메일을 확인해주세요.',
            maxWidth: Get.width * 0.8,
            borderRadius: 12,
            duration: Duration(seconds: 5));
  }

  bool isEmailValid(String email) {
    // 이메일 형식이 올바른지 확인하는 정규식
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }
}
