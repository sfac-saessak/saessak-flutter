import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/controller/community/community_controller.dart';
import 'package:saessak_flutter/util/app_color.dart';
import 'package:saessak_flutter/util/app_text_style.dart';
import '../../../model/community/post.dart';
import '../../../model/user_model.dart';

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
        child: ListView(
          children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  child: Chip(label: Text(post.tag, style: AppTextStyle.body4_m().copyWith(color: AppColor.white),), backgroundColor: AppColor.primary,)),
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
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: user.profileImg != null ? NetworkImage(user.profileImg!) : null,
                      ),
                      SizedBox(width: 10,),
                      Text(user.name, style: AppTextStyle.body1_m(), maxLines: 1, overflow: TextOverflow.ellipsis,),
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
          Divider(color: AppColor.black,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              post.title,
              style: AppTextStyle.header3(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Divider(color: AppColor.black,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(controller.convertTime(post.writeTime)),
              Text('조회수 ${post.views}'),
            ],
          ),
          SizedBox(height: 15,),

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
          SizedBox(height: 15,),
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
              Text('댓글 ${post.commentsNum}', style: AppTextStyle.body4_b(),),
              TextButton(
                child: Text('댓글 작성'),
                onPressed: () async {
                  Get.defaultDialog(
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: controller.commentTextController,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => controller.completeComment(post),
                          child: const Text('완료'),
                        )
                      ],
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
