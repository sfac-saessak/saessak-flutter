
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/follow/friends_controller.dart';
import '../../../util/app_color.dart';
import '../../widget/app_text_field.dart';
import '../../widget/friend_tile.dart';

class SearchFriendScreen extends GetView<FriendsController> {
  const SearchFriendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.black10,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: AppTextField(
                      hintText: '이메일주소 입력',
                      controller: controller.searchController,
                    ),
                  )
                ),
                IconButton(
                  icon: Icon(Icons.search, color: AppColor.black40),
                  onPressed: controller.searchFriend,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Obx(() => controller.searchResult.value != null
            ? FriendTile(user: controller.searchResult.value!) : Container(),
          )
        ],
      ),
    );
  }
}
