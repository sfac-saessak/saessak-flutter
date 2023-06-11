
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/follow/friends_list_controller.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';

class FriendsListPage extends GetView<FriendsListController> {
  const FriendsListPage({Key? key, required this.userName, required this.followingList, required this.followerList}) : super(key: key);
  final String userName;
  final RxList followingList;
  final RxList followerList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text('${userName}', style: AppTextStyle.body2_m()),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
      ),
      body: Column(
        children: [
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
    );
  }
}

