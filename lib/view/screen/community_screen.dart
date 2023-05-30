import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:saessak_flutter/component/community/post_card.dart';
import 'package:saessak_flutter/controller/community/community_controller.dart';
import 'package:saessak_flutter/view/page/community/post_write_page.dart';

// 페이지네이션 미구현

class CommunityScreen extends GetView<CommunityController> {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.titleController.text = '';
            controller.contentController.text ='';
            controller.imgXfileList.value =[];
            Get.to(PostWritePage());
          },
          child: Text('글쓰기')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () {
                    // 누르면 해당 태그 값으로 컨트롤러 curTag 값 변경. 해당 태그 값 변경시 해당되는 포스트만 db에서 가져와서 리빌드.
                  },
                  child: Chip(label: Text('전체'))),
              Chip(label: Text('정보')),
              Chip(label: Text('질문')),
              Chip(label: Text('잡담'))
            ],
          ),
          Expanded(
            child: Obx(
              ()=> ListView(
                children: [
                  TextButton(
                    onPressed: () {
                      controller.getPosts();
                    },
                    child: Text('게시글 새로고침'),
                  ),
                  // docs 리스트 -> post 리스트. map ((e) => PostCard(post: e)).toList()
                      
                  ...controller.postList.value!
                      .map((e) => PostCard(post: e))
                      .toList()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
