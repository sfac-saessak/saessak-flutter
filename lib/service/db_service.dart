
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/challenge.dart';
import '../model/journal.dart';
import '../model/message.dart';
import '../model/plant.dart';

class DBService {
  final String? uid;
  DBService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  final CollectionReference challengeCollection = FirebaseFirestore.instance.collection("challenges");
  final CollectionReference plantsCollection = FirebaseFirestore.instance.collection("plants");
  final CollectionReference followCollection = FirebaseFirestore.instance.collection("follow");
  final CollectionReference communityCollection = FirebaseFirestore.instance.collection("community");
  final CollectionReference journalsCollection = FirebaseFirestore.instance.collection("journals");
  final CollectionReference noticeCollection = FirebaseFirestore.instance.collection("notice");
  final CollectionReference forestCollection = FirebaseFirestore.instance.collection("forest");


  /* ############################## 유저 정보 ############################## */
  // 사용자 정보 저장
  saveUserInfoToFirestore(User user) async {
    final userDocRef = userCollection.doc(user.uid);
    final userDocSnapshot = await userDocRef.get();
    final userFollowDocRef = followCollection.doc(user.uid);
    final userForestDocRef = forestCollection.doc(user.uid);

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
      await userFollowDocRef.set({
        'following': [],
        'follower': [],
      });
      await userForestDocRef.set({
        'tree': [],
      });
    }
  }

  // uid로 유저 정보 가져오기
  getUserInfoById(String uid) {
    final userDocRef = userCollection.doc(uid);
    final userDoc = userDocRef.get().then((snapshot) {
      return snapshot.data() as Map<String, dynamic>;
    });
    return userDoc;
  }


  /* ############################## 식물 관리 ############################## */
  // 식물 저장
  Future addPlant(Plant plant) async {
    DocumentReference plantDocRef = await plantsCollection.doc(uid).collection("plant").add(plant.toMap());

    await plantDocRef.update({
      'plantId': plantDocRef.id,
    });
    createTree();
  }

  // 식물 가져오기
  Future getPlants() async {
    return plantsCollection.doc(uid).collection("plant").orderBy('createdAt', descending: true).get();
  }

  // 식물 삭제
  Future deletePlant(String plantId) async {
    await plantsCollection.doc(uid).collection("plant").doc(plantId).delete();

    final journalQuerySnapshot = await journalsCollection
        .doc(uid)
        .collection("journal")
        .where("plant", isEqualTo: plantId)
        .get();

    for (var document in journalQuerySnapshot.docs) {
      await document.reference.delete();
    }
    deleteTree();
  }

  // 나무 생성
  void createTree() {
    final treeIdx = Random().nextInt(11);
    var position = Random().nextInt(281) + 40;

    FirebaseFirestore.instance
        .collection('forest')
        .doc(uid)
        .get()
        .then((snapshot) {
      final trees = snapshot.data()?['tree'];

      if (trees != null) {
        bool overlap = false;
        for (var tree in trees) {
          final existingPosition = tree['position'];

          if ((position >= existingPosition - 20 && position <= existingPosition + 20) ||
              position == existingPosition) {
            overlap = true;
            break;
          }
        }

        if (!overlap) {
          FirebaseFirestore.instance
              .collection('forest')
              .doc(uid)
              .update({
            'tree': FieldValue.arrayUnion([
              {'treeIdx': treeIdx, 'position': position}
            ])
          });
        } else {
          createTree();
        }
      } else {
        FirebaseFirestore.instance
            .collection('forest')
            .doc(uid)
            .update({
          'tree': FieldValue.arrayUnion([
            {'treeIdx': treeIdx, 'position': position}
          ])
        });
      }
    });
  }

  // 나무 삭제
  void deleteTree() {
    FirebaseFirestore.instance
        .collection('forest')
        .doc(uid)
        .get()
        .then((snapshot) {
      final trees = snapshot.data()?['tree'];

      if (trees != null && trees.isNotEmpty) {
        final lastTree = trees.last;

        FirebaseFirestore.instance
            .collection('forest')
            .doc(uid)
            .update({
          'tree': FieldValue.arrayRemove([lastTree])
        });
      }
    });
  }


  /* ############################## 친구 관리 ############################## */
  // 친구 검색
  Future searchFriend(String email) async {
    return userCollection.where('email', isEqualTo: email).get();
  }

  // 팔로우/팔로우 취소
  Future toggleUserFollow(String uid) async {
    final userFollowDocRef = followCollection.doc(this.uid);
    final friendFollowDocRef = followCollection.doc(uid);

    DocumentSnapshot documentSnapshot = await userFollowDocRef.get();
    List<dynamic> following = await documentSnapshot['following'];

    if (following.contains(uid)) {
      await userFollowDocRef.update({
        'following': FieldValue.arrayRemove([uid])
      });
      await friendFollowDocRef.update({
        'follower': FieldValue.arrayRemove([this.uid])
      });
    } else {
      await userFollowDocRef.update({
        'following': FieldValue.arrayUnion([uid])
      });
      await friendFollowDocRef.update({
        'follower': FieldValue.arrayUnion([this.uid])
      });
    }
  }

  // 팔로우중인 유저인지 판별
  Future<bool> isUserFollowed(String uid) async {
    final userFollowDocRef = followCollection.doc(this.uid);
    DocumentSnapshot documentSnapshot = await userFollowDocRef.get();

    List<dynamic> following = await documentSnapshot['following'];
    if (following.contains(uid)) {
      return true;
    } else {
      return false;
    }
  }

  // 팔로잉 가져오기
  Future getFollowing(String uid) async {
    final userFollowDocRef = followCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userFollowDocRef.get();

    List<dynamic> following = await documentSnapshot['following'];
    return following;
  }

  // 팔로워 가져오기
  Future getFollower(String uid) async {
    final userFollowDocRef = followCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userFollowDocRef.get();

    List<dynamic> follower = await documentSnapshot['follower'];
    return follower;
  }

  // 유저 게시글 가져오기
  getUserPosts(String uid) async {
    return communityCollection.where('userUid', isEqualTo: uid).get();
  }


  /* ############################## 일지 ############################## */
  // 일지 저장
  Future addJournal(Journal journal) async {
    DocumentReference journalDocRef = await journalsCollection.doc(uid).collection("journal").add(journal.toMap());

    await journalDocRef.update({
      'journalId': journalDocRef.id,
    });
  }

  // 일지 가져오기
  Future readJournal(String uid, bool sort) async {
    return journalsCollection.doc(uid).collection("journal").orderBy('writeTime', descending: sort).get();
  }

  // plantId로 식물 정보 가져오기
  getPlantById(String uid, String plantId) {
    final plantDocRef = plantsCollection.doc(uid).collection("plant").doc(plantId);
    final plantDoc = plantDocRef.get().then((snapshot) {
      return snapshot.data() as Map<String, dynamic>;
    });
    return plantDoc;
  }

  // 일지 삭제
  Future deleteJournal(String journalId) async {
    await journalsCollection.doc(uid).collection("journal").doc(journalId).delete();
  }

  // 북마크
  Future toggleBookmark(String journalId) async {
    DocumentReference journalDocRef = journalsCollection.doc(uid).collection("journal").doc(journalId);
    DocumentSnapshot snapshot = await journalDocRef.get();
    var journalData = snapshot.data() as Map<String, dynamic>;

    bool currentValue = journalData['bookmark'];
    bool updatedValue = !currentValue;

    Map<String, dynamic> updatedData = {'bookmark': updatedValue};

    // Firestore 문서 업데이트
    await journalDocRef.update(updatedData);
  }


  /* ############################## 챌린지 ############################## */
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

    DocumentSnapshot groupSnapshot = await groupDocumentReference.get();
    List<dynamic> members = await groupSnapshot['members'];

    if (members.length <= 0) {
      await groupDocumentReference.delete();
    }
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
      "recentMessageSender": message.sender!.name,
      "recentMessageTime": message.time,
    });
  }


  /* ############################## 공지 ############################## */
  // 공지 가져오기
  Future readNotice() async {
    return noticeCollection.get();
  }
}
