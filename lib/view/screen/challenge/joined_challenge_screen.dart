
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../controller/challenge/challenge_controller.dart';
import '../../../util/app_color.dart';
import '../../widget/joined_challenge_tile.dart';

class JoinedChallengeScreen extends GetView<ChallengeController> {
  const JoinedChallengeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightGrey,
      padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
      child: Stack(
        children: [
          Obx(
            () => SmartRefresher(
              controller: controller.joinedRefreshController,
              onRefresh: controller.joinedChallengeRefresh,
              header: WaterDropHeader(),
              child: ListView.builder(
                itemCount: controller.joinedChallengeList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: JoinedChallengeTile(challenge: controller.joinedChallengeList[index]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
