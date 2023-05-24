
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // 로그인
  login(String email, String password) {
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).catchError((error) {
      // 로그인 실패
      Get.snackbar('로그인 실패', '아이디와 비밀번호를 다시 확인하세요.');
    });
  }

  // 로그아웃
  logout() => FirebaseAuth.instance.signOut();

  // 회원가입
  signup(String email, String password) {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password
    );
  }

  // 구글 로그인
  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Firestore에 사용자 정보 저장
  saveUserInfoToFirestore(User user) async {
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final userDocSnapshot = await userDocRef.get();

    if (userDocSnapshot.exists) {
      // 문서가 이미 존재하는 경우 업데이트
      await userDocRef.update({
        'email': user.email,
        'name': user.displayName,
        'profileImg': user.photoURL,
      });
    } else {
      // 문서가 존재하지 않는 경우 생성
      await userDocRef.set({
        'uid': user.uid,
        'email': user.email,
        'name': user.displayName,
        'profileImg': user.photoURL,
      });
    }
  }
}
