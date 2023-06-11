
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/component/community/post_card.dart';

import '../../../controller/follow/friend_detail_controller.dart';
import '../../../util/app_color.dart';

class FriendPostScreen extends GetView<FriendDetailController> {
  const FriendPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primary5,
      child: Obx(
        () => ListView.builder(
          itemCount: controller.postList.length,
          itemBuilder: (context, index) {
            return PostCard(post: controller.postList[index]);
          },
        ),
      ),
    );
  }
}
