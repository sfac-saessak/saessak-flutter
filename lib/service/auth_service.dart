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
    } on FirebaseAuthException catch (e) {
      // 에러 발생시
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
  signup(String email, String password) async {
    var res = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password).then((value) =>  Get.rawSnackbar(
          title: '회원가입 성공',
          message: '환영합니다! 프로필 정보를 입력해주세요.',
          maxWidth: Get.width * 0.8,
          borderRadius: 12,
          duration: Duration(seconds: 5)) )
        .catchError((e) {
      if (e.code == 'email-already-in-use') {
        Get.rawSnackbar(
            title: '회원가입 실패',
            message: '이미 사용중인 이메일 주소입니다.',
            maxWidth: Get.width * 0.8,
            borderRadius: 12,
            duration: Duration(seconds: 5));
      }
      if (e.code == 'invalid-email') {
        Get.rawSnackbar(
            title: '회원가입 실패',
            message: '유효하지 않은 이메일 주소입니다.',
            maxWidth: Get.width * 0.8,
            borderRadius: 12,
            duration: Duration(seconds: 5));
      }
      if (e.code == 'operation-not-allowed') {
        Get.rawSnackbar(
            title: '회원가입 실패',
            message: '사용할 수 없는 이메일/비밀번호 입니다.',
            maxWidth: Get.width * 0.8,
            borderRadius: 12,
            duration: Duration(seconds: 5));
      }
      if (e.code == 'weak-password') {
        Get.rawSnackbar(
            title: '회원가입 실패',
            message: '너무 쉬운 비밀번호 입니다.',
            maxWidth: Get.width * 0.8,
            borderRadius: 12,
            duration: Duration(seconds: 5));
      }
    });

  }


  // 비밀번호 재설정 메일 발송
  sendResetPasswordEmail (String email) async {
    await FirebaseAuth.instance
    .sendPasswordResetEmail(email: email);
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
