
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/service/db_service.dart';

import '../../model/user_model.dart';
import '../../view/screen/friends/following_screen.dart';
import '../../view/screen/friends/search_friend_screen.dart';

class FriendsController extends GetxController with GetSingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();   //
  late TabController tabController;         // 탭바 컨트롤러

  Rxn<UserModel> searchResult = Rxn();

  final List<Tab> tabs = <Tab>[             // 탭
    Tab(text: '팔로잉'),
    Tab(text: '친구검색'),
  ];

  final List<Widget> tabViews = <Widget>[   // 탭 뷰
    FollowingScreen(),
    SearchFriendScreen(),
  ];

  // 친구 검색
  searchFriend() async {
    QuerySnapshot snapshot = await DBService().searchFriend(searchController.text);
    if (snapshot.docs.isNotEmpty) {
      searchResult(UserModel.fromMap(snapshot.docs.first.data() as Map<String, dynamic>));
    } else {
      searchResult(null);
    }
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }
}
