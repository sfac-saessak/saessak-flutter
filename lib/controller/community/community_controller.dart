import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/model/community/post.dart';

class CommunityController extends GetxController {
// 페이지네이션 어떻게 할지 확인하고 구성할 것.
// 포스트 데이터 가져오기 -> PostModel로 맵핑하기 -> postList에 추가??
  List<Post> postList = List.generate(
      10,
      (index) => Post(
          tag: '질문글',
          userInfo: {'nickName': '$index번째유저'},
          title: 'title: 식물이 말라가요 도와줭 $index',
          content: '내용내용내용 글내용 내용내요 식물이 말라가고 이쒀여 도와주세여 흐귷규 $index',
          photoURL: [],
          views: 123,
          reportNum: 0,
          comments: [{}, {}, {}, {}],
          writeTime: Timestamp.fromDate(DateTime.now())));
}
