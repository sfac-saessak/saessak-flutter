import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/controller/community/community_controller.dart';
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
        onTap: () async {
          Get.find<CommunityController>().goPost(post);
        },
        child: SizedBox(
            height: 240,
            child: Card(
              child: Column(children: [
                Row(
                  children: [
                    Chip(label: Text(post.tag)),
                    Text(post.title),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Text(
                      post.content,
                      maxLines: 7,
                    ),
                    if (post.imgUrlList.isNotEmpty)
                      Container(
                        child: Image.network(
                          post.imgUrlList[0],
                          fit: BoxFit.cover,
                        ),
                        color: Colors.grey,
                        height: Get.height * 0.1,
                        width: Get.height * 0.1,
                      ),
                  ],
                ),
                Divider(),
                Text('작성자: ${post.userInfo['nickName']}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Get.find<CommunityController>()
                        .convertTime(post.writeTime)),
                    Text('조회수${post.views}'),
                    Text('댓글수${post.commentsNum}'),
                  ],
                )
              ]),
            )),
      ),
    );
  }
}
