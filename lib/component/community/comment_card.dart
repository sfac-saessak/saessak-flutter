
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/controller/community/community_controller.dart';


class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
    required this.nickName,
    required this.content,
    required this.writeTime
  });

final String nickName;
final String content;
final Timestamp writeTime;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
        IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
      ],
    ),
    ],);
  }
}
