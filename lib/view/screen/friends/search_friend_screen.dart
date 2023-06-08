
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/follow/friends_controller.dart';
import '../../../util/app_color.dart';
import '../../widget/app_text_field.dart';

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
            ? ListTile(
                leading: CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.grey,
                  child: controller.searchResult.value!.profileImg == null ? Icon(Icons.person, color: Colors.white) : null,
                  backgroundImage: controller.searchResult.value!.profileImg != null
                      ? NetworkImage(controller.searchResult.value!.profileImg!)
                      : null,
                ),
                title: Text(controller.searchResult.value!.name),
                subtitle: Text(controller.searchResult.value!.email),
                // trailing: Container(
                //   width: 80,
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(30.0),
                //         ),
                //         elevation: 0
                //     ),
                //     onPressed: controller.followFriend,
                //     child: Text('팔로우', style: NotoSans.regular),
                //   ),
                // ),
              )
              : Container(),
          )
        ],
      ),
    );
  }
}
