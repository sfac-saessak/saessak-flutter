
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
  logout() {
    Get.defaultDialog(
      title: '로그아웃',
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      content: Text('정말 로그아웃하시겠습니까?'),
      actions: [
        Container(
          width: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              backgroundColor: Colors.grey,
              elevation: 0,
            ),
            onPressed: () {
              Get.back();
            },
            child: Text('취소'),
          ),
        ),
        SizedBox(width: 20,),
        Container(
          width: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              backgroundColor: Colors.red,
              elevation: 0,
            ),
            onPressed: () {
              Get.back();
              AuthService().logout();
            },
            child: Text('확인'),
          ),
        ),
      ],
    );
  }

  // 회원가입
  signup(String email, String pw) => AuthService().signup(email, pw);

  // 구글 로그인
  signInWithGoogle() => AuthService().signInWithGoogle();

  @override
  onInit() {
    super.onInit();
    FirebaseAuth.instance.authStateChanges().listen((value) {
      user(value);
      if (value != null) {
        // 유저가 있는 상태
        if (user.value!.metadata.creationTime == user.value!.metadata.lastSignInTime) {    // 계정 생성 후 첫 로그인
          Get.offAllNamed(AppRoutes.setName);
        } else {
          Get.offAllNamed(AppRoutes.main);
        }
      } else {
        // 유저가 없는 상태
        Get.offAllNamed(AppRoutes.login);
      }
    });
  }
}
