import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/follow/friends_controller.dart';
import '../../model/user_model.dart';
import '../../util/app_color.dart';
import '../../util/app_text_style.dart';
import '../page/friends/friend_detail_page.dart';

class FriendTile extends StatelessWidget {
  const FriendTile({Key? key, required this.user, required this.isFollowed})
      : super(key: key);

  final UserModel user;
  final RxBool isFollowed;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<FriendsController>();
    return Obx(
      () => GestureDetector(
        onTap: () => Get.to(() => FriendDetailPage(), arguments: [user]),
        child: ListTile(
          contentPadding: EdgeInsets.zero, // 패딩 제거
          leading: CircleAvatar(
            radius: 36,
            backgroundColor: Colors.grey,
            child: user.profileImg == null
                ? Icon(Icons.person, color: Colors.white)
                : null,
            backgroundImage:
                user.profileImg != null ? NetworkImage(user.profileImg!) : null,
          ),
          title: Text(user.name, style: AppTextStyle.body2_m()),
          subtitle: Text(user.email,
              style: AppTextStyle.body4_r(color: AppColor.black40)),
          trailing: Container(
            width: 110,
            height: 35,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isFollowed.value ? AppColor.black10 : AppColor.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  elevation: 0),
              onPressed: () {
                controller.toggleUserFollow(user.uid);
                isFollowed(!isFollowed.value);
              },
              child: isFollowed.value
                  ? Text('팔로잉', style: AppTextStyle.body3_m())
                  : Text('팔로우',
                      style: AppTextStyle.body3_m(color: AppColor.white)),
            ),
          ),
        ),
      ),
    );
  }
}
