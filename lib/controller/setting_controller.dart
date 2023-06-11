
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/community/post.dart';
import '../model/user_model.dart';
import '../service/db_service.dart';
import 'follow/friends_controller.dart';
import 'schedule_journal/journal_controller.dart';

class SettingController extends GetxController {
  User get user => FirebaseAuth.instance.currentUser!;

  RxList journalList = Get.find<JournalController>().journalList;      // 일지 리스트
  RxList followingList = Get.find<FriendsController>().followingList;  // 팔로잉 리스트
  RxList followerList = [].obs;             // 팔로워 리스트
  RxList myPostList = [].obs;               // 게시글 리스트
  RxBool isLoading = false.obs;             // 로딩중 상태

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
    myPostList([]);
    QuerySnapshot snapshot = await DBService().getUserPosts(user.uid);
    myPostList(snapshot.docs.map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>)).toList());
    log('${myPostList}');
    isLoading(false);
  }

  // uid로 유저 정보 가져오기
  getUserInfoById(String uid) async {
    var userInfo = await DBService().getUserInfoById(uid);
    return userInfo;
  }

  @override
  void onInit() {
    getFollower();
    readPost();
    super.onInit();
  }
}
