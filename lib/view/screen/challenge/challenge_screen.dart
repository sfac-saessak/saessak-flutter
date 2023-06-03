
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/challenge/challenge_controller.dart';

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
            labelColor: Colors.black,
            indicatorColor: Colors.black,
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
