import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/controller/community/community_controller.dart';
import 'package:saessak_flutter/model/user_model.dart';
import 'package:saessak_flutter/util/app_color.dart';
import 'package:saessak_flutter/util/app_text_style.dart';

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
      required this.authorUid,
      required this.user
      });

  final String nickName;
  final String content;
  final Timestamp writeTime;
  final String commentId;
  final Post post;
  final String authorUid;
  final UserModel user;



  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Divider(color: AppColor.darkGrey,),
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
                    Text(user.name),
                  ],
                ),
              ),
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(content),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: 
              Text('${Get.find<CommunityController>().convertTime(writeTime)}', textAlign: TextAlign.end,style: AppTextStyle.body4_r().copyWith(color: AppColor.grey,),)
              
          
          
        ),
      ],
    );
  }
}
