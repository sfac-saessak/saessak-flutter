
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/follow/friend_detail_controller.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';

class FriendDetailPage extends GetView<FriendDetailController> {
  const FriendDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
      ),
      body: Obx(
        () => Container(
          width: Get.width,
          color: AppColor.white,
          child: Column(
            children: [
              Container(
                width: 110,
                height: 110,
                child: CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.grey,
                  child: controller.user.profileImg == null ? Icon(Icons.person, color: Colors.white) : null,
                  backgroundImage: controller.user.profileImg != null
                    ? NetworkImage(controller.user.profileImg!)
                    : null,
                ),
              ),
              SizedBox(height: 6),
              Text(controller.user.name, style: AppTextStyle.body2_m()),
              Text(controller.user.email, style: AppTextStyle.body4_r(color: AppColor.black40)),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text('${controller.followerList.length}', style: AppTextStyle.body1_m()),
                          SizedBox(height: 6),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColor.black10,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('팔로워'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          Text('${controller.followingList.length}', style: AppTextStyle.body1_m()),
                          SizedBox(height: 6),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColor.black10,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('팔로잉'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          Text('0', style: AppTextStyle.body1_m()),
                          SizedBox(height: 6),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColor.black10,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('일지'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          Text('${controller.postList.length}', style: AppTextStyle.body1_m()),
                          SizedBox(height: 6),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColor.black10,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('게시글'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              TabBar(
                controller: controller.tabController,
                tabs: controller.tabs,
                labelColor: AppColor.primary, // 선택된 탭의 색상
                unselectedLabelColor: AppColor.black20, // 선택되지 않은 탭의 색상
                indicatorColor: AppColor.primary,
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller.tabController,
                  children: controller.tabViews,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

