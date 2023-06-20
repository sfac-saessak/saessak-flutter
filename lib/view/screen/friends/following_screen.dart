import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/view/widget/friend_tile.dart';

import '../../../controller/follow/friends_controller.dart';
import '../../../model/user_model.dart';

class FollowingScreen extends GetView<FriendsController> {
  const FollowingScreen({Key? key, required this.followingList}) : super(key: key);

  final RxList<UserModel> followingList;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: followingList.length,
                itemBuilder: (context, index) {
                  UserModel user = followingList[index];
                  return FriendTile(user: user, isFollowed: true.obs);
                },
              ),
            ),
    );
  }
}
