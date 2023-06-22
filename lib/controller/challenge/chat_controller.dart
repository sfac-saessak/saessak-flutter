import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/challenge.dart';
import '../../model/message.dart';
import '../../model/user_model.dart';
import '../../service/db_service.dart';
import 'challenge_controller.dart';

class ChatController extends GetxController {
  Challenge challenge = Get.arguments[0];
  TextEditingController messageController = TextEditingController();
  RxList<Message> chats = <Message>[].obs;
  User user = FirebaseAuth.instance.currentUser!;
  ScrollController scrollController = ScrollController();
  RxList<UserModel> memberList = <UserModel>[].obs;
  Timestamp? lastChatTime; // 가장 최근 채팅 시간

  @override
  void onInit() {
    super.onInit();
    log('chat group => ${challenge.title}');
    getMembers();

    // Firestore 컬렉션의 스트림을 구독하여 추가된 채팅만 갱신
    FirebaseFirestore.instance
        .collection('challenges')
        .doc(challenge.challengeId)
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        updateChats(snapshot.docs);
      }
      update(); // GetX에게 상태 업데이트를 알림
    });

    ever(chats, (_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });
    });
  }

  // 채팅 업데이트
  void updateChats(List<QueryDocumentSnapshot> docs) async {
    var newMessages = <Message>[];
    var userInfoFutures = <Future<Map<String, dynamic>>>[];

    for (var doc in docs) {
      var message = doc.data() as Map<String, dynamic>;
      var messageTime = message['time'] as Timestamp;

      // 가장 최근 채팅의 시간 이후에 추가된 채팅만 가져옴
      if (lastChatTime != null && messageTime.compareTo(lastChatTime!) <= 0) {
        continue;
      }

      var userInfoFuture = getUserInfoById(message['sender']);
      userInfoFutures.add(userInfoFuture);

      var newMessage = Message(
        message: message['message'],
        sender: null,
        time: messageTime,
      );
      newMessages.add(newMessage);
    }

    var userInfos = await Future.wait(userInfoFutures);
    for (var i = 0; i < userInfos.length; i++) {
      var userInfo = userInfos[i];
      var userModel = UserModel.fromMap(userInfo);
      newMessages[i].sender = userModel;
    }

    if (newMessages.isNotEmpty) {
      chats.addAll(newMessages);
      lastChatTime = newMessages.last.time;
    }
  }

  // 메세지 보내기
  void sendMessage(String challengeId) async {
    if (messageController.text.isNotEmpty) {
      var userInfo = await getUserInfoById(user.uid);
      var userModel = UserModel.fromMap(userInfo);
      Message message = Message(
          message: messageController.text,
          sender: userModel,
          time: Timestamp.now());
      DBService().sendMessage(challengeId, message);
      messageController.clear();
    }
  }

  // uid로 유저 정보 가져오기
  Future<Map<String, dynamic>> getUserInfoById(String uid) async {
    var userInfo = await DBService().getUserInfoById(uid);
    return userInfo;
  }

  // 멤버 가져오기
  getMembers() async {
    List<UserModel> members = [];
    for (var member in challenge.members!) {
      var userInfo = await getUserInfoById(member);
      members.add(UserModel.fromMap(userInfo));
    }

    // UserModel? admin;
    // for (var member in members) {
    //   if (member.uid == challenge.admin) {
    //     admin = member;
    //     break;
    //   }
    // }
    //
    // members.remove(admin);
    // members.insert(0, admin!);

    memberList(members);
  }

  // 참여자 내보내기
  void removeMember(String challengeId, String uid) async {
    await DBService().removeMember(challengeId, uid);
  }

  // 챌린지 포기
  void exitChallenge(String challengeId) async {
    await DBService(uid: user.uid).exitChallenge(challengeId);
    Get.back();
    Get.find<ChallengeController>().getJoinedChallenges();
    Get.find<ChallengeController>().updateAllChallenge();
  }

  // 어드민 채팅방 나가기
  void exitAdmin(String challengeId, String newAdminUid) async {
    await DBService(uid: user.uid).changeAdmin(challengeId, newAdminUid);
    exitChallenge(challengeId);
    Get.back();
  }

  @override
  void onClose() {
    Get.find<ChallengeController>().getJoinedChallenges();
    scrollController.dispose();
    log('onClose');
    super.onClose();
  }
}