
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view/screen/friends/following_screen.dart';
import '../../view/screen/friends/search_friend_screen.dart';

class FriendsController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;         // 탭바 컨트롤러

  final List<Tab> tabs = <Tab>[             // 탭
    Tab(text: '팔로잉'),
    Tab(text: '친구검색'),
  ];

  final List<Widget> tabViews = <Widget>[   // 탭 뷰
    FollowingScreen(),
    SearchFriendScreen(),
  ];

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
