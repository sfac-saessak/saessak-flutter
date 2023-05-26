import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/community/post.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(children: [
          Chip(label: Text(post.tag)),
          Text(
            post.title,
            style: TextStyle(fontSize: 30),
            maxLines: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('3시간 전 . 조회수 ${post.views}'),
              PopupMenuButton(
                onSelected: (value) {
                  
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
          Divider(),
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.green,
                child: Text('프로필이미지'),
              ),
              Text(post.userInfo['nickName']),
            ],
          ),
          Divider(),
          Container(
            width: Get.width * 0.7,
            height: Get.height * 0.25,
            child: Text('사진'),
            color: Colors.green[100],
          ),
          Text(post.content),
          SizedBox(
            height: 100,
          ),

          // 이하 댓글부
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('댓글 ${post.comments.length}'),
              TextButton(onPressed: () {}, child: Text('댓글쓰기')),
            ],
          ),
          Divider(),
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.green,
                child: Text('프로필이미지'),
              ),
              Text(post.userInfo['nickName']),
            ],
          ),
          Text('위 댓글 작성자 프로필, 댓글 내용은 post.comment 에서 받음'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DateTime.now().toString()),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
            ],
          ),
          Divider(),
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.green,
                child: Text('프로필이미지'),
              ),
              Text(post.userInfo['nickName']),
            ],
          ),
          Text('위 댓글 작성자 프로필, 댓글 내용은 post.comment 에서 받음'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DateTime.now().toString()),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
            ],
          ),
          Divider(),
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.green,
                child: Text('프로필이미지'),
              ),
              Text(post.userInfo['nickName']),
            ],
          ),
          Text('위 댓글 작성자 프로필, 댓글 내용은 post.comment 에서 받음'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DateTime.now().toString()),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
            ],
          )
        ]),
      ),
    );
  }
}
