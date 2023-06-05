import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:saessak_flutter/controller/login_controller.dart';

class AuthService {
  // 로그인
  login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) { // 에러 발생시
      switch (e.code) {
        case 'invalid-email':
          Get.find<LoginController>().emailErrorText.value = '유효하지 않은 이메일입니다.';
          Get.find<LoginController>().pwErrorText.value = null;
          return;
        case 'user-not-found':
          Get.find<LoginController>().emailErrorText.value = '존재하지 않는 사용자입니다.';
          Get.find<LoginController>().pwErrorText.value = null;
          return;
        case 'wrong-password':
          Get.find<LoginController>().pwErrorText.value = '비밀번호가 일치하지 않습니다.';
          Get.find<LoginController>().emailErrorText.value = null;
          return;
        default:
          Get.rawSnackbar(
              message: '로그인에 실패하였습니다. 입력된 이메일 주소와 비밀번호를 확인해주세요.',
              maxWidth: Get.width * 0.8,
              borderRadius: 12,
              mainButton: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('확인')),
              duration: Duration(seconds: 5));
      }
    }
  }

  // 로그아웃
  logout() => FirebaseAuth.instance.signOut();

  // 회원가입
  signup(String email, String password) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  // 구글 로그인
  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
