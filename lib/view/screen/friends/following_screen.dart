
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/view/widget/friend_tile.dart';

import '../../../controller/follow/friends_controller.dart';

class FollowingScreen extends GetView<FriendsController> {
  const FollowingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: controller.followingList.length,
        itemBuilder: (context, index) {
          return FriendTile(user: controller.followingList[index]);
        },
      ),
    );
  }
}
