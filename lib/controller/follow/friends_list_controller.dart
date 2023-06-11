
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view/screen/friends/following_screen.dart';
import '../../view/screen/friends/follower_screen.dart';

class FriendsListController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;         // 탭바 컨트롤러

  final List<Tab> tabs = <Tab>[             // 탭
    Tab(text: '팔로워'),
    Tab(text: '팔로잉'),
  ];

  final List<Widget> tabViews = <Widget>[   // 탭 뷰
    FollowerScreen(),
    FollowingScreen(),
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
