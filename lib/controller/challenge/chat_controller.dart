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

  @override
  void onInit() {
    super.onInit();
    log('chat group => ${challenge.title}');
    getMembers();
    // Firestore 컬렉션의 스트림을 구독하여 chats 리스트 갱신
    FirebaseFirestore.instance
        .collection('challenges')
        .doc(challenge.challengeId)
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        updateChats(snapshot.docs);
      } else {
        chats([]);
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
    var futureMessages = docs.map((doc) async {
      var message = doc.data() as Map<String, dynamic>;

      var userInfo = await getUserInfoById(message['sender']);
      var userModel = UserModel.fromMap(userInfo);
      return Message(
        message: message['message'],
        sender: userModel,
        time: message['time'],
      );
    }).toList();

    var messages = await Future.wait(futureMessages);
    chats(messages);
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
  void getMembers() async {
    List<UserModel> members = [];
    for (var member in challenge.members!) {
      var userInfo = await getUserInfoById(member);
      members.add(UserModel.fromMap(userInfo));
    }
    memberList(members);
  }

  @override
  void onClose() {
    Get.find<ChallengeController>().getJoinedChallenges();
    scrollController.dispose();
    log('onClose');
    super.onClose();
  }
}
