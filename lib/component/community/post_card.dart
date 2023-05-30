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
          if(FirebaseAuth.instance.currentUser!.uid != post.userInfo['uid']){
            print('조회수 증가 대상 해당');
            await FirebaseFirestore.instance.collection('community').doc(post.postId).update({'views': FieldValue.increment(1)});
          print('조회수 증가 완료');
          }
          print('조회수 증가 대상 해당하지 않음');
          await Get.find<CommunityController>().getComments(post);
          Get.to(PostDetailPage(post: post));},
        child: SizedBox(
          height: 240,
          child: Card(
            child: Column(children: [
              Text(post.title),
              Divider(),
              Row(
                children: [
                  Text(post.content, maxLines: 7,),
                  if(post.imgUrlList.isNotEmpty)
                  Container(
                                  child: Image.network(
                                    post.imgUrlList[0],
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.grey,
                                  height: Get.height * 0.1,
                                  width: Get.height * 0.1,
                                ) ,
                ],
              ),
              Divider(),
              Text(post.userInfo['nickName']),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('작성시간'),
                  Text('조회수${post.views}'),
                  Text('댓글수'),
                  
                ],
              )
            ]),
          )),
      ),
    );
  }
}