
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../controller/challenge/challenge_controller.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';
import '../../page/challenge/add_challenge_page.dart';
import '../../widget/challenge_tile.dart';

class AllChallengeScreen extends GetView<ChallengeController> {
  const AllChallengeScreen({Key? key}) : super(key: key);

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
                    itemCount: controller.allChallengeFilter.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10, top: 8, bottom: 8),
                        child: GestureDetector(
                          onTap: () {
                            controller.allFilterSelectedIdx(index);
                            if (controller.allFilterSelectedIdx == 0) {
                              controller.updateAllChallenge();
                            } else {
                              controller.filterAllChallenge(controller.allChallengeFilter[controller.allFilterSelectedIdx.value]);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: controller.allFilterSelectedIdx.value == index ? AppColor.primary : AppColor.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                '${controller.allChallengeFilter[index]}',
                                style: AppTextStyle.body4_r(color: controller.allFilterSelectedIdx.value == index ? AppColor.white : AppColor.black)
                              )
                            )
                          ),
                        ),
                      );
                    }
                  ),
                ),
                controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(
                    child: SmartRefresher(
                      controller: controller.allRefreshController,
                      onRefresh: controller.allChallengeRefresh,
                      header: WaterDropHeader(),
                      child: ListView.builder(
                        itemCount: controller.allFilterSelectedIdx == 0 ? controller.allChallengeList.length : controller.filteredAllChallengeList.length,
                        itemBuilder: (context, index) {
                          var challenge = controller.allFilterSelectedIdx == 0 ? controller.allChallengeList[index] : controller.filteredAllChallengeList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: ChallengeTile(challenge: challenge),
                          );
                        },
                      ),
                    ),
                  ),
              ],
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
