import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/model/community/post.dart';

class CommunityController extends GetxController {
// 페이지네이션 어떻게 할지 확인하고 구성할 것.
// 포스트 데이터 가져오기 -> PostModel로 맵핑하기 -> postList에 추가??


// #### 메인페이지
  // 임시로 포스트 구현
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






// #### post_write_page controll
  RxString dropDownVal = '정보'.obs;


 RxList<String> imgPathList = <String>[].obs;
    // 작성하기 버튼
    writePost () async {
      // 1. if 올린 사진 있다 -> 사진 storage에 업로드 후 await Url 받아오기
      // 2. 사진 url 포함한 데이터 db에 업로드(doc 생성)
      //   2-1. 올릴 데이터 뭐뭐? -> 작성일, 태그, 작성자정보(현재유저정보 그대로), 제목, 본문 등
      
    }








  // #### post_detail_page controll

    // ## 게시글 내용 받아오기 -> DB에서 받아오는건 Post post로 메인화면에서 그대로 받아옴.
    //   -> 문제: 메인화면 구성시 DB에서 받아온 post가 오래되어 최신 post와 다른 경우.
    //      => 해결1 : 무시하고 최초 받아온 데이터로 모든 것을 진행(빠른 실행, 비용상의 이점)
    //      => 해결2 : 해당 post 디테일 페이지로 이동시 다시 해당 post에 대한 데이터를 db에 요청(댓글 최신화, 게시글 수정여부 반영 등에서 이점)


    // ## 게시글 수정
    modifyPost ()async {
      // 게시글 작성페이지로 이동
      // 제목, 본문은 컨트롤러로 초기값 = 현재작성값 으로 줌. 사진은 받아온 networkimage url을 활용해서 구현(작성, 수정이냐에 따른 분기로 사진 리스트뷰 내용 달라지게만 하면 될 듯)
      // 게시글 수정페이지(작성페이지 동)에서 작성완료시(얘도 분기줘서 수정완료로..?) DB에 업로드 후 업로드 성공시 작성 완료된 내용 반영된 게시글 detailpage로 이동(스택 삭제)
    }

    // ## 게시글 삭제
    removePost () async {
      // 해당 doc을 삭제. 하위 컬렉션 삭제 x 문제 확인하고 사용자 접근 가능여부 확인
      // 삭제 후 커뮤니티 메인화면으로 돌아감
    }
    
    // ## 댓글쓰기 버튼
    writeComment() async {
      // 해당 문서 docId 이용하여 해당 문서의 comments<array> 필드에 추가할 것 -> 몇개까지 되나? 순서대로 들어가는지 확인 기타 등등
    }


    // ## 댓글 삭제기능
    removeComment() async {
      // 문제: 게시글 내용 받아오기 문제와 연결. 댓글은 comments<List>을 이용하여 구현한다. 어떻게 구현?
      //    => 해결1 : 삭제시 로컬에서 삭제한 뒤 전체 comments<List> 자체를 다시 업로드 할 것인지 (중간 타이밍에 이루어진 다른 사용자의 댓글 작성, 수정 누락 위험)
      //1안 => 해결2 : DB에 바로 해당 field의 수정을 요청할 것인지. 댓글 하나하나는 map으로 들어가니까 키값 넣어서 구별은 가능. (이게 가능한지 모르겠음. 하나의 array에 어느정도까지 데이터가 들어갈지도 모르겠)
    }


    // ## 신고하기
    report () async {
      // 신고기능. 플레이스토어, 앱스토어 심사규정 확인 후 구체적 구현 계획할 것.
    }
}
