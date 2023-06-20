import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/app_routes.dart';
import '../service/auth_service.dart';

class AuthController extends GetxController {
  final Rxn<User> user = Rxn<User>();

  // 로그인
  login(String id, String pw) => AuthService().login(id, pw);

  // 로그아웃
  logout() => AuthService().logout();

  // 회원가입
  signup(String email, String pw) => AuthService().signup(email, pw);

  // 비밀번호 재설정 메일 발송
  sendResetPasswordEmail(String email) =>
      AuthService().sendResetPasswordEmail(email);

  // 구글 로그인
  signInWithGoogle() => AuthService().signInWithGoogle();

  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(2500.milliseconds); // 스플래시 화면 기다림
    FirebaseAuth.instance.authStateChanges().listen((value) {
      user(value);
      if (value != null) {
        // 유저가 있는 상태
        if (user.value!.displayName == null) {
          Get.offAllNamed(AppRoutes.setName);
        } else {
          Get.offNamed(AppRoutes.main);
        }
      } else {
        // 유저가 없는 상태
        Get.offAllNamed(AppRoutes.login);
      }
    });
  }
}
