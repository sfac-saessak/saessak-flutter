
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/challenge/challenge_controller.dart';
import '../../../util/app_color.dart';

class ChallengeScreen extends GetView<ChallengeController> {
  const ChallengeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          TabBar(
            controller: controller.tabController,
            tabs: controller.tabs,
            labelColor: AppColor.primary, // 선택된 탭의 색상
            unselectedLabelColor: AppColor.grey, // 선택되지 않은 탭의 색상
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
