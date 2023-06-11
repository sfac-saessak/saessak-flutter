import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/controller/community/community_controller.dart';
import 'package:saessak_flutter/util/app_color.dart';
import 'package:saessak_flutter/util/app_text_style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../model/community/post.dart';

class PostWritePage extends GetView<CommunityController> {
  PostWritePage({super.key, this.post});

  final Post? post;

  @override
  Widget build(BuildContext context) {
    if (post != null) {
      controller.titleController.text = post!.title;
      controller.contentController.text = post!.content;
      controller.imgDownloadUrlList = post!.imgUrlList;
    }
    if (post == null) {
      controller.imgDownloadUrlList = [];
    }

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        foregroundColor: AppColor.black,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: post == null
            ? Text(
                '게시글 작성',
                style: AppTextStyle.body2_m(),
              )
            : Text(
                '게시글 수정',
                style: AppTextStyle.body2_m(),
              ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () async {
            await controller.getPosts();
            Get.back();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (post != null) {
                // 수정글 DB에 저장
                controller.modifyPost(post!);
              } else {
                //작성글 DB에 저장
                controller.writePost();
              }
            },
            child: Text(
              '완료',
              style: AppTextStyle.body3_m().copyWith(color: AppColor.primary),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(color: AppColor.black30, thickness: 3),
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.titleController,
                            maxLines: 2,
                            decoration: InputDecoration(
                                hintText: '제목을 입력해주세요 (최대 2줄)',
                                hintStyle: AppTextStyle.body1_m()
                                    .copyWith(color: AppColor.black30),
                                border: InputBorder.none),
                          ),
                        ),
                        Obx(
                          () => DropdownButton(
                            items: [
                              DropdownMenuItem(child: Text('정보'), value: '정보'),
                              DropdownMenuItem(child: Text('질문'), value: '질문'),
                              DropdownMenuItem(child: Text('잡담'), value: '잡담')
                            ],
                            onChanged: (String? value) {
                              controller.dropDownVal.value = value!;
                            },
                            value: controller.dropDownVal.value,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Color(0xffCCCCCC),
                    ),
                    SizedBox(
                      height: 300,
                      child: Obx(
                        () => Stack(children: [
                          PageView(
                            controller: controller.photoPageController,
                            children: [
                              ...controller.imgDownloadUrlList
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          child: Container(
                                            child: Image.network(
                                              e,
                                              fit: BoxFit.cover,
                                            ),
                                            color: Colors.grey,
                                            height: Get.height * 0.1,
                                            width: Get.height * 0.1,
                                          ),
                                          onTap: () => controller
                                              .imgDownloadUrlList
                                              .remove(e)
                                          // 탭하면 추가한 사진 삭제
                                          ,
                                        ),
                                      ))
                                  .toList(),
                              ...controller.imgXfileList.map((e) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    child: Container(
                                      child: Image.asset(
                                        e.path,
                                        fit: BoxFit.cover,
                                      ),
                                      color: Colors.grey,
                                      height: Get.height * 0.1,
                                      width: Get.height * 0.1,
                                    ),
                                    onTap: () => controller.imgXfileList
                                        .remove(e) // 탭하면 추가한 사진 삭제
                                    ,
                                  ),
                                );
                              }).toList(),
                              GestureDetector(
                                onTap: () => controller.addPhoto(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Icon(
                                      Icons.add,
                                      color: AppColor.black20,
                                    ),
                                    color: AppColor.black10,
                                    height: Get.height * 0.1,
                                    width: Get.height * 0.1,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Positioned(
                            bottom: 20,
                            right: 20,
                            child: SmoothPageIndicator(
                                controller: controller.photoPageController,
                                count: controller.imgDownloadUrlList.length +
                                    controller.imgXfileList.length +
                                    1,
                                effect: SlideEffect(
                                    dotWidth: 12.0,
                                    dotHeight: 12.0,
                                    dotColor: AppColor.black20,
                                    activeDotColor: AppColor.primary),
                                onDotClicked: (index) {}),
                          ),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        maxLines: 15,
                        controller: controller.contentController,
                        decoration: InputDecoration(
                            hintText: '내용을 입력해주세요',
                            hintStyle: AppTextStyle.body3_m()
                                .copyWith(color: AppColor.black30),
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
