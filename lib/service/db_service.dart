
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBService {
  final String? uid;
  DBService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection = FirebaseFirestore.instance.collection("challenges");

  // 사용자 정보 저장
  saveUserInfoToFirestore(User user) async {
    final userDocRef = userCollection.doc(user.uid);
    final userDocSnapshot = await userDocRef.get();

    if (userDocSnapshot.exists) {
      // 문서가 이미 존재하는 경우 업데이트
      await userDocRef.update({
        'name': user.displayName,
        'profileImg': user.photoURL,
      });
    } else {
      // 문서가 존재하지 않는 경우 생성
      await userDocRef.set({
        'uid': user.uid,
        'email': user.email,
        "challenges": [],
        'name': user.displayName,
        'profileImg': user.photoURL,
      });
    }
  }
}
