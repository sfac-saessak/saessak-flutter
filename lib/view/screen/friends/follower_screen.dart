import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/controller/follow/friends_controller.dart';

import '../../../controller/setting_controller.dart';
import '../../../model/user_model.dart';
import '../../widget/friend_tile.dart';

class FollowerScreen extends GetView<SettingController> {
  const FollowerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: controller.followerList.length,
        itemBuilder: (context, index) {
          UserModel user = controller.followerList[index];

          return FriendTile(user: user, isFollowed: false.obs);
        },
      ),
    );
  }
}
