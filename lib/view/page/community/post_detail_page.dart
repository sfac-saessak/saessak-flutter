import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/controller/community/community_controller.dart';

import '../../../component/community/comment_card.dart';
import '../../../model/community/post.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class PostDetailPage extends GetView<CommunityController> {
  const PostDetailPage({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    print(post.imgUrlList);
    TextEditingController _commentTextController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(children: [
          Row(children: [
            Chip(label: Text(post.tag)),
            Text(
            post.title,
            style: TextStyle(fontSize: 30),
            maxLines: 3,
          ),
          ],),
          
          Text(controller.convertTime(post.writeTime)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text('${DateTime.fromMillisecondsSinceEpoch(post.writeTime.millisecondsSinceEpoch)}')),
              Text('조회수 ${post.views}'),
              PopupMenuButton(
                onSelected: (value) {
                  if(SampleItem.itemOne == value){
                    print('게시글수정');
                    controller.moveToModifyPostPage(post);
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
          //...사진리스트.map((e) => 사진 컨테이너)
          ...post.imgUrlList.map((e) {
            print(e);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: Get.width * 0.7,
                height: Get.height * 0.25,
                child: Image.network('$e'),
              ),
            );
          }).toList(),

          Text(post.content),
          SizedBox(
            height: 100,
          ),

          // 이하 댓글부
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('댓글 0'),
              TextButton(
                child: Text('댓글 작성'),
                onPressed: () async {
                  Get.defaultDialog(
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: _commentTextController,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            Get.find<CommunityController>().writeComment(
                                content: _commentTextController.text,
                                post: post);
                            await controller.getComments(post);
                            Get.back();
                          },
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
              children:
                  Get.find<CommunityController>().commentList.value != null
                      ? Get.find<CommunityController>()
                          .commentList
                          .value!
                          .map(
                            (e) => CommentCard(
                              nickName: e.data()['userInfo']['nickName'],
                              content: e.data()['content'],
                              writeTime: e.data()['writeTime'],
                            ),
                          )
                          .toList()
                      : []

              // 커멘트 컬렉션 . get() . docs . map ( (e) => Comment.fromMap(e.data())) . toList()
              ,
            ),
          ),
        ]),
      ),
    );
  }
}
