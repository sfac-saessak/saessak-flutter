import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/controller/community/community_controller.dart';

import '../../model/community/post.dart';

enum SampleItem { itemOne, itemTwo }

class CommentCard extends GetView<CommunityController> {
  const CommentCard(
      {super.key,
      required this.nickName,
      required this.content,
      required this.writeTime,
      required this.commentId,
      required this.post,
      required this.authorUid});

  final String nickName;
  final String content;
  final Timestamp writeTime;
  final String commentId;
  final Post post;
  final String authorUid;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.green,
              child: Text('프로필이미지'),
            ),
            Text(nickName),
          ],
        ),
        Text(content),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${Get.find<CommunityController>().convertTime(writeTime)}'),
            PopupMenuButton(
              onSelected: (value) async {
                if (value == SampleItem.itemOne) {
                  controller.removeComment(post, commentId, authorUid);
                }
                if (value == SampleItem.itemTwo) {}
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<SampleItem>>[
                const PopupMenuItem(
                  value: SampleItem.itemOne,
                  child: Text('댓글 삭제'),
                ),
                const PopupMenuItem<SampleItem>(
                  value: SampleItem.itemTwo,
                  child: Text('댓글 신고'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
