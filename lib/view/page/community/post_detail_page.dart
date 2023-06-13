import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/controller/community/community_controller.dart';
import 'package:saessak_flutter/util/app_color.dart';
import 'package:saessak_flutter/util/app_text_style.dart';
import '../../../model/community/post.dart';
import '../../../model/user_model.dart';
import '../friends/friend_detail_page.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class PostDetailPage extends GetView<CommunityController> {
  const PostDetailPage({super.key, required this.post, required this.user});

  final Post post;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시글'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColor.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(controller: controller.scrollController, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                    child: Chip(
                  label: Text(
                    post.tag,
                    style:
                        AppTextStyle.body4_m().copyWith(color: AppColor.white),
                  ),
                  backgroundColor: AppColor.primary,
                )),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(() => FriendDetailPage(),
                            arguments: [user]), //
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: user.profileImg != null
                              ? NetworkImage(user.profileImg!)
                              : null,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        user.name,
                        style: AppTextStyle.body1_m(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    if (value == SampleItem.itemOne) {
                      controller.moveToModifyPostPage(post);
                    }
                    if (value == SampleItem.itemTwo) {
                      controller.removePost(post);
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<SampleItem>>[
                    const PopupMenuItem(
                      value: SampleItem.itemOne,
                      child: Text('게시글 수정'),
                    ),
                    const PopupMenuItem<SampleItem>(
                      value: SampleItem.itemTwo,
                      child: Text('게시글 삭제'),
                    ),
                    const PopupMenuItem<SampleItem>(
                      value: SampleItem.itemThree,
                      child: Text('신고하기'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: AppColor.black,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              post.title,
              style: AppTextStyle.header3(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Divider(
            color: AppColor.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(controller.convertTime(post.writeTime)),
              Text('조회수 ${post.views}'),
            ],
          ),
          SizedBox(
            height: 15,
          ),

          ...post.imgUrlList.map((e) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: Get.width * 0.76,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network('$e')),
              ),
            );
          }).toList(),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.content),
          ),
          SizedBox(
            height: 100,
          ),

          // 이하 댓글부
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '댓글 ${post.commentsNum}',
                style: AppTextStyle.body4_b(),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColor.primary),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: Text(
                  '댓글 작성',
                  style: AppTextStyle.body4_b(color: AppColor.primary),
                ),
                onPressed: () async {
                  controller.commentTextController.text = '';
                  controller.isButtonEnabled.value = false;
                  Get.dialog(
                    Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17)),
                        height: 525,
                        width: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColor.black10,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      onChanged: (value) =>
                                          controller.onChanged(),
                                      maxLines: 27,
                                      controller:
                                          controller.commentTextController,
                                      decoration: InputDecoration(
                                          hintText: '댓글 내용을 입력해주세요.',
                                          hintStyle: AppTextStyle.body3_r()
                                              .copyWith(
                                                  color: AppColor.black50),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(
                                () => OutlinedButton(
                                  onPressed: () =>
                                      controller.completeComment(post),
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor:
                                        controller.isButtonEnabled.value
                                            ? AppColor.primary
                                            : AppColor.white,
                                    side: BorderSide(color: AppColor.primary),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  child: Text(
                                    '작성 완료',
                                    style: AppTextStyle.body3_r(
                                        color: controller.isButtonEnabled.value
                                            ? AppColor.white
                                            : AppColor.primary),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Obx(
            () => Column(
                children: controller.commentCardList.value != null
                    ? [...controller.commentCardList.value!]
                    : []),
          ),
        ]),
      ),
    );
  }
}
