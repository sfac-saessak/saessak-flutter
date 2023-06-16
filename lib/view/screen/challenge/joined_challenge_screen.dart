
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../controller/challenge/challenge_controller.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';
import '../../widget/joined_challenge_tile.dart';

class JoinedChallengeScreen extends GetView<ChallengeController> {
  const JoinedChallengeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.black10,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: [
          Obx(
            () => Column(
              children: [
                Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.joinedChallengeFilter.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10, top: 8, bottom: 8),
                        child: GestureDetector(
                          onTap: () {
                            controller.joinedFilterSelectedIdx(index);
                            if (controller.joinedFilterSelectedIdx == 0) {
                              controller.getJoinedChallenges();
                            } else {
                              controller.filterJoinChallenge(controller.joinedChallengeFilter[controller.joinedFilterSelectedIdx.value]);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: controller.joinedFilterSelectedIdx.value == index ? AppColor.primary : AppColor.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                '${controller.joinedChallengeFilter[index]}',
                                style: AppTextStyle.body4_r(color: controller.joinedFilterSelectedIdx.value == index ? AppColor.white : AppColor.black)
                              )
                            )
                          ),
                        ),
                      );
                    }
                  ),
                ),
                Expanded(
                  child: SmartRefresher(
                    controller: controller.joinedRefreshController,
                    onRefresh: controller.joinedChallengeRefresh,
                    header: WaterDropHeader(),
                    child: ListView.builder(
                      itemCount: controller.joinedFilterSelectedIdx == 0 ? controller.joinedChallengeList.length : controller.filteredJoinChallengeList.length,
                      itemBuilder: (context, index) {
                        var challenge = controller.joinedFilterSelectedIdx == 0 ? controller.joinedChallengeList[index] : controller.filteredJoinChallengeList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: JoinedChallengeTile(challenge: challenge),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
