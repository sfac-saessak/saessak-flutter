import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/component/community/comment_card.dart';
import 'package:saessak_flutter/model/community/post.dart';
import 'package:saessak_flutter/view/page/community/post_detail_page.dart';
import 'package:saessak_flutter/view/page/community/post_write_page.dart';

class CommunityController extends GetxController {
// 페이지네이션..?
// 포스트 데이터 가져오기 -> PostModel로 맵핑하기 -> postList에 추가??

// #### 메인페이지
  Rxn<List<Post>> postList = Rxn([]);

  // postList 가져오기 + 포스트리스트 생성
  getPosts() async {
    var postsData = await FirebaseFirestore.instance
        .collection('community')
        .orderBy('writeTime', descending: true)
        .get();
    postList.value = postsData.docs.map((e) => Post.fromMap(e.data())).toList();

    print(postList.value);
  }

// #### post_write_page controll
  RxString dropDownVal = '정보'.obs;
  RxList imgXfileList = [].obs;
  List imgDownloadUrlList =
      []; // List<Xfile> 형식을 firestore에 업로드 후, 다운로드url을 받아 imgDownloadUrlList에 넣어준 뒤, 해당 리스트를 DB > post의 field에 넣어주는 형식
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();


  // 작성하기 버튼 
  writePost() async {
    // 로딩중 시작, 함수 종료시 로딩중 끝
    Get.defaultDialog(
      backgroundColor: Colors.transparent,
      title: '업로드중입니다.',
      content: CircularProgressIndicator()
    );

    // 2. 사진 url 포함한 데이터 db에 업로드(doc 생성)
    print('db업로드 시작');
    var res = await FirebaseFirestore.instance.collection('community').add({
      'writeTime': DateTime.now(),
      'userInfo': {
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'nickName': FirebaseAuth.instance.currentUser!.displayName,
        'profileImg': FirebaseAuth.instance.currentUser!.photoURL,
        'email': FirebaseAuth.instance.currentUser!.email
      },
      'tag': dropDownVal.value,
      'title': titleController.text,
      'content': contentController.text,
      'imgUrlList': imgDownloadUrlList,
      'views': 0,
      'reportNum': 0
    });

    print('db 기본정보 업로드 완료');

    // xfileList의 이미지 업로드 후 imgDownUrl list에 다운로드 유알엘 저장
    if (imgXfileList.isNotEmpty) {
      for (int i = 0; i < imgXfileList.length; i++) {
        var ref = await FirebaseStorage.instance
            .ref()
            .child('/community/post/images/${res.id}/image$i');
        var result = await ref.putFile(File(imgXfileList[i].path));
        print(result);
        print('업로드 완료 : image$i');

        var fileUrl = await ref.getDownloadURL();

        print('downloadUrl : $fileUrl');
        imgDownloadUrlList.add(fileUrl);
        print(imgDownloadUrlList);
      }
    }

// 이미지다운 리스트 포함된 정보 db에 업로드
    await FirebaseFirestore.instance
        .collection('community')
        .doc('${res.id}')
        .set({'postId': res.id, 'imgUrlList': imgDownloadUrlList},
            SetOptions(merge: true));

    var data = await FirebaseFirestore.instance
        .collection('community')
        .doc('${res.id}')
        .get();
    Post post = Post.fromMap(data.data()!);

    print('db에 postid 추가 완료');

    // 작성 완료 후 작성자료 초기화
    imgXfileList.value = [];
    imgDownloadUrlList = [];
    titleController.text = '';
    contentController.text = '';

    // 작성 완료 후 작성한 페이지로 이동
    Get.off(PostDetailPage(post: post)); // 왜 이전 write페이지가 스택에서 삭제가 안될까잉

    // 로딩중 끝
  }

  // #### post_detail_page controll

  // ## 게시글 내용 받아오기 -> DB에서 받아오는건 Post post로 메인화면에서 그대로 받아옴. => #### 메인페이지 에서 해결함.
  //   -> 문제: 메인화면 구성시 DB에서 받아온 post가 오래되어 최신 post와 다른 경우.
  //      => 해결1 : 무시하고 최초 받아온 데이터로 모든 것을 진행(빠른 실행, 비용상의 이점)
  //      => 해결2 : 해당 post 디테일 페이지로 이동시 다시 해당 post에 대한 데이터를 db에 요청(댓글 최신화, 게시글 수정여부 반영 등에서 이점)
  //        =>>> 현재 : 최초 커뮤니티 스크린 구성시 getPosts() 사용하여 posts 받아옴. 받아온 post로 postcard 만들고, postdetail page에 해당 post를 그대로 전달.

  // ## 게시글 수정

  // 1. 게시글 작성페이지로 이동. 게시글 작성페이지에서 기존에 작성한 데이터를 post에서 받아서 구성.
  moveToModifyPostPage(Post post) {

    if(FirebaseAuth.instance.currentUser!.uid == post.userInfo['uid']){
       // 게시글 작성페이지로 이동
    Get.off(PostWritePage(post: post));
    }
    else {
      Get.snackbar('권한이 없습니다.', '글의 작성자와 현재 사용자가 일치하지 않습니다.');
    }
   
  }

  // 2. 기존 게시글의 내용 대신 수정한 게시글의 내용을 firebase에 업로드 + 3. 수정된 데이터를 받아와 post에 넣고 postdetailpage로 이동(스택 삭제)
  modifyPost(Post post) async {}

  // ## 게시글 삭제
  removePost() async {
    // 해당 doc을 삭제. 하위 컬렉션 삭제 x 문제 확인하고 사용자 접근 가능여부 확인
    // 삭제 후 커뮤니티 메인화면으로 돌아감
  }

  // ## comment 받아오기
  Rxn<List> commentList = Rxn([]);
  getComments(Post post) async {
    var res = await FirebaseFirestore.instance
        .collection('community')
        .doc(post.postId)
        .collection('comments')
        .orderBy('writeTime')
        .get();
    commentList.value = res.docs;
  }

  // ## 댓글쓰기 버튼
  writeComment({required String content, required Post post}) async {
    // 해당 post의 postId 이용하여 post doc > comments collection > comment doc 에 작성
    await FirebaseFirestore.instance
        .collection('community')
        .doc(post.postId)
        .collection('comments')
        .add({
      'userInfo': {
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'nickName': FirebaseAuth.instance.currentUser!.displayName,
        'profileImg': FirebaseAuth.instance.currentUser!.photoURL,
        'email': FirebaseAuth.instance.currentUser!.email
      },
      'content': content,
      'reportNum': 0,
      'writeTime': DateTime.now()
    });

    // comment collection 전체를 다시 받아온다.
    var comments = await FirebaseFirestore.instance
        .collection('community')
        .doc(post.postId)
        .collection('comments')
        .get();

    // 받아온 comment collection 이용하여 댓글부만 rebuild(obx 이용)
  }

  // ## 댓글 삭제기능
  removeComment() async {
    // 문제: 게시글 내용 받아오기 문제와 연결. 댓글은 comments<List>을 이용하여 구현한다. 어떻게 구현?
    //    => 해결1 : 삭제시 로컬에서 삭제한 뒤 전체 comments<List> 자체를 다시 업로드 할 것인지 (중간 타이밍에 이루어진 다른 사용자의 댓글 작성, 수정 누락 위험)
    //1안 => 해결2 : DB에 바로 해당 field의 수정을 요청할 것인지. 댓글 하나하나는 map으로 들어가니까 키값 넣어서 구별은 가능. (이게 가능한지 모르겠음. 하나의 array에 어느정도까지 데이터가 들어갈지도 모르겠)
  }

  // ## 신고하기
  report() async {
    // 신고기능. 플레이스토어, 앱스토어 심사규정 확인 후 구체적 구현 계획할 것.
  }

// 시간 변환 함수
  String convertTime(Timestamp time) {
    DateTime writeTime = time.toDate();

    Duration difference = DateTime.now().difference(writeTime);
    print(difference);

    if (difference.inDays > 0) {
      return '${difference.inDays} 일 전';
    }
    if (difference.inDays <= 0 && difference.inHours > 0) {
      return '${difference.inHours} 시간 전';
    }
    if (difference.inDays <= 0 && difference.inHours <= 0) {
      return '${difference.inMinutes} 분 전';
    }
    return '?';
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPosts();
  }
}
