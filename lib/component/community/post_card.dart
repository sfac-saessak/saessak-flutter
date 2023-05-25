import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/model/community/post.dart';
import 'package:saessak_flutter/view/page/community/post_detail_page.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () => Get.to(PostDetailPage(post: post)),
        child: SizedBox(
          height: 240,
          child: Card(
            child: Column(children: [
              Text(post.title),
              Divider(),
              Text(post.content),
              Divider(),
              Text(post.userInfo['nickName']),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('작성시간'),
                  Text('조회수${post.views}'),
                  Text('댓글수${post.comments.length}'),
                  
                ],
              )
            ]),
          )),
      ),
    );
  }
}