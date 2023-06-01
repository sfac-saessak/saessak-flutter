import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:saessak_flutter/component/community/post_card.dart';
import 'package:saessak_flutter/controller/community/community_controller.dart';
import 'package:saessak_flutter/view/page/community/post_write_page.dart';

// 페이지네이션 미구현

class CommunityScreen extends GetView<CommunityController> {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.titleController.text = '';
            controller.contentController.text = '';
            controller.imgXfileList.value = [];
            Get.to(() => PostWritePage());
          },
          child: Text('글쓰기')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () {
                    controller.curTab = '전체';
                    controller.getPosts();
                  },
                  child: Chip(label: Text('전체'))),
              GestureDetector(
                  onTap: () {
                    // 정보탭만 가져오기
                    controller.curTab = '정보';
                    controller.getInfoPosts();
                  },
                  child: Chip(label: Text('정보'))),
              GestureDetector(
                  onTap: () {
                    // 질문탭만 가져오기
                    controller.curTab = '질문';
                    controller.getQuestionPosts();
                  },
                  child: Chip(label: Text('질문'))),
              GestureDetector(
                  onTap: () {
                    // 잡담탭만 가져오기
                    controller.curTab = '잡담';
                    controller.getTalkPosts();
                  },
                  child: Chip(label: Text('잡담')))
            ],
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
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
          )
        ],
      ),
    );
  }
}
