
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/community/post.dart';
import '../../model/user_model.dart';
import '../../service/db_service.dart';
import '../../view/screen/friends/friend_journal_screen.dart';
import '../../view/screen/friends/friend_post_screen.dart';

class FriendDetailController extends GetxController with GetSingleTickerProviderStateMixin {
  UserModel user = Get.arguments[0];
  late TabController tabController;         // 탭바 컨트롤러

  RxList followingList = [].obs;            // 팔로잉 리스트
  RxList followerList = [].obs;             // 팔로잉 리스트
  RxList postList = [].obs;                 // 전체 챌린지 리스트
  RxBool isLoading = false.obs;             // 로딩중 상태

  final List<Tab> tabs = <Tab>[             // 탭
    Tab(text: '일지'),
    Tab(text: '게시글'),
  ];

  final List<Widget> tabViews = <Widget>[   // 탭 뷰
    FriendJournalScreen(),
    FriendPostScreen(),
  ];

  // 팔로잉 가져오기
  getFollowing() async {
    isLoading(true);
    var uidList = await DBService().getFollowing(user.uid);
    followingList(uidList);
    isLoading(false);
    log('${followingList}');
  }

  // 팔로워 가져오기
  getFollower() async {
    isLoading(true);
    var uidList = await DBService().getFollower(user.uid);
    followerList(uidList);
    log('${followerList}');
    isLoading(false);
  }

  // 유저 게시글 가져오기
  readPost() async {
    isLoading(true);
    postList([]);
    QuerySnapshot snapshot = await DBService().getUserPosts(user.uid);
    postList(snapshot.docs.map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>)).toList());
    log('${postList}');
    isLoading(false);
  }

  @override
  void onInit() {
    getFollowing();
    getFollower();
    readPost();
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
    log('onClose');
  }
}
