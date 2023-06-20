
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/community/post.dart';
import '../../model/journal.dart';
import '../../model/plant.dart';
import '../../model/user_model.dart';
import '../../service/db_service.dart';
import '../../view/screen/friends/friend_journal_screen.dart';
import '../../view/screen/friends/friend_post_screen.dart';

class FriendDetailController extends GetxController with GetSingleTickerProviderStateMixin {
  UserModel user = Get.arguments[0];
  late TabController tabController;         // 탭바 컨트롤러

  RxList<UserModel> followingList = <UserModel>[].obs; // 팔로잉 리스트
  RxList<UserModel> followerList = <UserModel>[].obs; // 팔로잉 리스트
  RxList postList = [].obs; // 게시글 리스트
  RxList journalList = [].obs; // 일지 리스트
  RxBool isLoading = false.obs; // 로딩중 상태

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
    List<UserModel> following = [];
    for (var uid in uidList) {
      var userInfo = await getUserInfoById(uid);
      following.add(UserModel.fromMap(userInfo));
    }
    followingList(following);
    isLoading(false);
    log('${followingList}');
  }

  // 팔로워 가져오기
  getFollower() async {
    isLoading(true);
    var uidList = await DBService().getFollower(user.uid);
    List<UserModel> follower = [];
    for (var uid in uidList) {
      var userInfo = await getUserInfoById(uid);
      follower.add(UserModel.fromMap(userInfo));
    }
    followerList(follower);
    log('${followerList}');
    isLoading(false);
  }

  // 유저 게시글 가져오기
  readPost() async {
    isLoading(true);
    postList([]);

    var resUser = await DBService().getUserInfoById(this.user.uid);
    UserModel authorUser = UserModel.fromMap(resUser);

    QuerySnapshot snapshot = await DBService().getUserPosts(user.uid);
    postList(snapshot.docs.map((doc) {
      Post post = Post.fromMap(doc.data() as Map<String, dynamic>);
      post.user = authorUser;
      return post;
    }).toList());
    log('${postList}');
    isLoading(false);
  }

  // 일지 가져오기
  void readJournal() async {
    isLoading(true);
    journalList([]);
    QuerySnapshot snapshot = await DBService().readJournal(user.uid, true);

    var futureJournals = snapshot.docs.map((doc) async {
      var journal = doc.data() as Map<String, dynamic>;
      var plantInfo = await getPlantById(journal['plant']);
      var plant = Plant.fromMap(plantInfo);
      bool bookmark = journal['bookmark'];
      return Journal(
        plant: plant,
        uid: journal['uid'],
        writeTime: journal['writeTime'],
        bookmark: bookmark.obs,
        content: journal['content'],
        imageUrl: journal['imageUrl'],
      );
    }).toList();

    var journals = await Future.wait(futureJournals);
    journalList(journals);

    log('journalList => ${journalList}');
    isLoading(false);
  }

  // 식물id로 식물 정보 가져오기
  Future<Map<String, dynamic>> getPlantById(String plantId) async {
    var plantInfo = await DBService().getPlantById(user.uid, plantId);
    return plantInfo;
  }

  // uid로 유저 정보 가져오기
  getUserInfoById(String uid) async {
    var userInfo = await DBService().getUserInfoById(uid);
    return userInfo;
  }

  @override
  void onInit() {
    getFollowing();
    getFollower();
    readPost();
    readJournal();
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void onClose() {
    super.onClose();
    log('onClose');
  }
}
