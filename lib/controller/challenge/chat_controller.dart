
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/challenge.dart';
import '../../model/message.dart';
import '../../service/db_service.dart';

class ChatController extends GetxController {
  Challenge challenge = Get.arguments[0];
  TextEditingController messageController = TextEditingController();
  RxList chats = [].obs;
  User user = FirebaseAuth.instance.currentUser!;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    log('chat group => ${challenge.title}');
    // Firestore 컬렉션의 스트림을 구독하여 chats 리스트 갱신
    FirebaseFirestore.instance
        .collection('challenges')
        .doc(challenge.challengeId)
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        chats(snapshot.docs.map((doc) => Message.fromMap(doc.data() as Map<String, dynamic>)).toList());
      } else {
        chats([]);
      }
      update(); // GetX에게 상태 업데이트를 알림
      log('chats => ${chats}');
    });

    ever(chats, (_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    });
  }

  // 메세지 보내기
  void sendMessage(String challengeId) {
    if (messageController.text.isNotEmpty) {
      Message message = Message(message: messageController.text, sender: user.displayName!, time: Timestamp.now());
      DBService().sendMessage(challengeId, message);
      messageController.clear();
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
