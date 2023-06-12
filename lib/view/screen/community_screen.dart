import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:saessak_flutter/component/community/post_card.dart';
import 'package:saessak_flutter/controller/community/community_controller.dart';
import 'package:saessak_flutter/view/page/community/post_write_page.dart';

import '../../util/app_color.dart';

class CommunityScreen extends GetView<CommunityController> {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black10,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.titleController.text = '';
          controller.contentController.text = '';
          controller.imgXfileList.value = [];
          Get.to(() => PostWritePage());
        },
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Image.asset('assets/images/Icons_pen.png'),
      ),
      body: Column(
        children: [
          // 상단 탭 바
          Container(
            color: AppColor.white,
            child: TabBar(
              controller: controller.communityTabController,
              tabs: controller.communityTabs,
              labelColor: AppColor.primary, // 선택된 탭의 색상
              unselectedLabelColor: AppColor.grey, // 선택되지 않은 탭의 색상
              indicatorColor: AppColor.primary,
            ),
          ),
          Expanded(
            child: Obx(
              () => SmartRefresher(
                controller: controller.communityRefreshController,
                onRefresh: controller.getRefresh,
                child: ListView.builder(
                    itemCount: controller.postList.value!.length,
                    itemBuilder: (context, index) {
                      if (controller.curTab == '전체') {
                        if ((index) % 5 == 4 &&
                            controller.postList.value!.length - 1 == index) {
                          controller.getMorePosts();
                        }
                      }
                      if (controller.curTab == '정보') {
                        if ((index) % 5 == 4 &&
                            controller.postList.value!.length - 1 == index) {
                          controller.getMoreInfoPosts();
                        }
                      }
                      if (controller.curTab == '질문') {
                        if ((index) % 5 == 4 &&
                            controller.postList.value!.length - 1 == index) {
                          controller.getMoreQuestionPosts();
                        }
                      }
                      if (controller.curTab == '잡담') {
                        if ((index) % 5 == 4 &&
                            controller.postList.value!.length - 1 == index) {
                          controller.getMoreTalkPosts();
                        }
                      }

                      return PostCard(post: controller.postList.value![index]);
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
