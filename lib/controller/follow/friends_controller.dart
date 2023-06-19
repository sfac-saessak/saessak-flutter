import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/service/db_service.dart';

import '../../model/user_model.dart';
import '../../view/screen/friends/following_screen.dart';
import '../../view/screen/friends/search_friend_screen.dart';

class FriendsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  User get user => FirebaseAuth.instance.currentUser!;
  TextEditingController searchController = TextEditingController(); // 이메일 검색
  late TabController tabController; // 탭바 컨트롤러

  RxList<UserModel> followingList = <UserModel>[].obs; // 팔로잉 리스트
  Rxn<UserModel> searchResult = Rxn(); // 검색 결과
  RxBool isLoading = false.obs; // 로딩중 상태

  final List<Tab> tabs = <Tab>[
    // 탭
    Tab(text: '팔로잉'),
    Tab(text: '친구검색'),
  ];

  final List<Widget> tabViews = <Widget>[
    // 탭 뷰
    FollowingScreen(),
    SearchFriendScreen(),
  ];

  // 친구 검색
  searchFriend() async {
    QuerySnapshot snapshot =
        await DBService().searchFriend(searchController.text);
    if (snapshot.docs.isNotEmpty) {
      searchResult(UserModel.fromMap(
          snapshot.docs.first.data() as Map<String, dynamic>));
    } else {
      searchResult(null);
    }
  }

  // 팔로우중인 유저 가져오기
  getFollowing() async {
    isLoading(true);
    var uidList = await DBService().getFollowing(user.uid);
    List<UserModel> following = [];
    for (var uid in uidList) {
      var userInfo = await getUserInfoById(uid);
      following.add(UserModel.fromMap(userInfo));
    }
    followingList(following);
    isLoading(false);
  }

  // 팔로우/취소
  toggleUserFollow(String uid) async {
    await DBService(uid: user.uid).toggleUserFollow(uid);
    getFollowing();
  }

  // 팔로우중인 유저인지 판별
  isUserFollowed(String uid) async {
    return await DBService(uid: user.uid).isUserFollowed(uid);
  }

  // uid로 유저 정보 가져오기
  getUserInfoById(String uid) async {
    var userInfo = await DBService().getUserInfoById(uid);
    return userInfo;
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    getFollowing();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }
}
