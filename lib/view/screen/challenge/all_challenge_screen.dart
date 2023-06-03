
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../controller/challenge/challenge_controller.dart';
import '../../../util/app_color.dart';
import '../../page/challenge/add_challenge_page.dart';
import '../../widget/challenge_tile.dart';

class AllChallengeScreen extends GetView<ChallengeController> {
  const AllChallengeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightGray,
      padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
      child: Stack(
        children: [
          Obx(
            () => SmartRefresher(
              controller: controller.refreshController,
              onRefresh: controller.onRefresh,
              header: WaterDropHeader(),
              child: ListView.builder(
                itemCount: controller.allChallengeList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: ChallengeTile(challenge: controller.allChallengeList[index]),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: ElevatedButton(
              onPressed: () => Get.to(() => AddChallengePage()),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: Colors.green,
                elevation: 0,
                padding: EdgeInsets.all(16.0), // 초록색 배경
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 24.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
