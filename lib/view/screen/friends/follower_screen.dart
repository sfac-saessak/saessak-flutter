import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/follow/friends_controller.dart';
import '../../../model/user_model.dart';
import '../../widget/friend_tile.dart';

class FollowerScreen extends StatelessWidget {
  const FollowerScreen({Key? key, required this.followerList}) : super(key: key);

  final RxList<UserModel> followerList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Obx(
        () => ListView.builder(
          itemCount: followerList.length,
          itemBuilder: (context, index) {
            UserModel user = followerList[index];
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
