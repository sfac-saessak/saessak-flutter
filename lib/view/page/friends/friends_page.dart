
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/follow/friends_controller.dart';
import '../../../util/app_color.dart';

class FriendsPage extends GetView<FriendsController> {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('친구 관리'),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
      ),
      body: Container(
        color: AppColor.white,
        child: Column(
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
      ),
    );
  }
}

