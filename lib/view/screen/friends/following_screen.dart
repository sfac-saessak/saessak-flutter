import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/follow/friends_controller.dart';
import '../../../model/user_model.dart';
import '../../widget/friend_tile.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({Key? key, required this.followingList}) : super(key: key);

  final RxList<UserModel> followingList;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: followingList.length,
          itemBuilder: (context, index) {
            UserModel user = followingList[index];
            RxBool isFollowed = RxBool(false);

            Get.find<FriendsController>()
                .isUserFollowed(user.uid)
                .then((value) {
              isFollowed(value);
            });
            return FriendTile(user: user, isFollowed: isFollowed);
          },
        ),
      ),
    );
  }
}
