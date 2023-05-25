import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:saessak_flutter/component/community/post_card.dart';
import 'package:saessak_flutter/controller/community/community_controller.dart';

class CommunityScreen extends GetView<CommunityController> {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: Text('글쓰기')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              child: Row(
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
            ),
          ),
          SliverAppBar(
            backgroundColor: Colors.green,
            expandedHeight: Get.height / 4,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                child: Text('슬리버 앱바'),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return PostCard(
              post: controller.postList[index],
            );
          }, childCount: controller.postList.length))
        ],
      ),
    );
  }
}
