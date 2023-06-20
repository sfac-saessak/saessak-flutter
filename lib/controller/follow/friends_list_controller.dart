
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/user_model.dart';
import '../../view/screen/friends/following_screen.dart';
import '../../view/screen/friends/follower_screen.dart';

class FriendsListController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;         // 탭바 컨트롤러
  RxList<UserModel> followingList = Get.arguments[0];
  RxList<UserModel> followerList = Get.arguments[1];

  final List<Tab> tabs = <Tab>[             // 탭
    Tab(text: '팔로워'),
    Tab(text: '팔로잉'),
  ];

  late List<Widget> tabViews = <Widget>[   // 탭 뷰
    FollowerScreen(followerList: followerList),
    FollowingScreen(followingList: followingList),
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    // tabViews = <Widget>[   // 탭 뷰
    //   FollowerScreen(followerList: followerList),
    //   FollowingScreen(followingList: followingList),
    // ];
  }

  @override
  void onClose() {
    super.onClose();
  }
}
