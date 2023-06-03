
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/challenge.dart';

class DBService {
  final String? uid;
  DBService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  final CollectionReference challengeCollection = FirebaseFirestore.instance.collection("challenges");

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

  // 챌린지 생성
  Future createChallenge(Challenge challenge) async {
    DocumentReference challengeDocumentReference = await challengeCollection.add({
      'challengeId': "",
      'plant': challenge.plant,
      'admin': uid,
      'title': challenge.title,
      'content': challenge.content,
      'createdAt': DateTime.now(),
      'startDate': challenge.startDate,
      'endDate': challenge.endDate,
      'members': [],
      'memberLimit': challenge.memberLimit,
      'image': challenge.imageUrl,
      'recentMessage': '',
      'recentMessageSender': '',
    });

    // 멤버 업데이트
    await challengeDocumentReference.update({
      'members': FieldValue.arrayUnion(["${uid}"]),
      'challengeId': challengeDocumentReference.id,
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      'challenges': FieldValue.arrayUnion(["${challengeDocumentReference.id}"])
    });
  }

  // 전체 챌린지 가져오기
  getUserGroups() async {
    DocumentSnapshot userDoc = await userCollection.doc(uid).get();
    if (userDoc.exists) {
      var groupList = userDoc.get('groups');
      return groupList;
    }
  }
}
