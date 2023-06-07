
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/challenge.dart';
import '../model/message.dart';
import '../model/plant.dart';

class DBService {
  final String? uid;
  DBService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  final CollectionReference challengeCollection = FirebaseFirestore.instance.collection("challenges");
  final CollectionReference plantsCollection = FirebaseFirestore.instance.collection("plants");

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

  getUserInfoById(String uid) {
    final userDocRef = userCollection.doc(uid);
    final userDoc = userDocRef.get().then((snapshot) {
      return snapshot.data() as Map<String, dynamic>;
    });
    return userDoc;
  }

  // 식물 저장
  Future addPlant(Plant plant) async {
    DocumentReference plantDocRef = await plantsCollection.doc(uid).collection("plant").add(plant.toMap());

    await plantDocRef.update({
      'plantId': plantDocRef.id,
    });
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
      'recentMessageTime': DateTime.now(),
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
  Future getAllChallenge() async {
    return challengeCollection.orderBy('createdAt', descending: true).get();
  }

  // 챌린지 참가
  Future joinChallenge(String challengeId) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = challengeCollection.doc(challengeId);

    await userDocumentReference.update({
      "challenges": FieldValue.arrayUnion(["${challengeId}"])
    });
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}"])
    });
  }

  // 챌린지 포기
  Future exitChallenge(String challengeId) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = challengeCollection.doc(challengeId);

    await userDocumentReference.update({
      "challenges": FieldValue.arrayRemove(["${challengeId}"])
    });
    await groupDocumentReference.update({
      "members": FieldValue.arrayRemove(["${uid}"])
    });
  }

  // 참여중인 챌린지 가져오기
  getJoinedChallenges() async {
    DocumentSnapshot userDoc = await userCollection.doc(uid).get();
    if (userDoc.exists) {
      return userDoc.get('challenges');
    }
  }

  // 챌린지 검색
  searchChallengeByPlant(String plant) {
    return challengeCollection.where("plant", isEqualTo: plant).get();
  }

  // 메세지 보내기
  sendMessage(String groupId, Message message) async {
    challengeCollection.doc(groupId).collection("messages").add(message.toMap());
    challengeCollection.doc(groupId).update({
      "recentMessage": message.message,
      "recentMessageSender": message.sender.name,
      "recentMessageTime": message.time,
    });
  }
}
