import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saessak_flutter/component/community/comment_card.dart';
import 'package:saessak_flutter/model/community/post.dart';
import 'package:saessak_flutter/view/page/community/post_detail_page.dart';
import 'package:saessak_flutter/view/page/community/post_write_page.dart';
import 'package:saessak_flutter/view/screen/community_screen.dart';

class CommunityController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final db = FirebaseFirestore.instance;

// #### 메인페이지
  Rxn<List<Post>> postList = Rxn([]);
  DocumentSnapshot? lastVisible;
  String curTab = '전체';

  // 탭 컨트롤러
  late TabController communityTabController;

// 탭 리스트
  final List<Tab> communityTabs = <Tab>[
    Tab(text: '전체'),
    Tab(text: '정보'),
    Tab(text: '질문'),
    Tab(text: '잡담'),
  ];

  // 탭 리스터 실행함수
  void _handleTabSelection() {
    if (communityTabController.indexIsChanging) {
      int selectedTabIndex = communityTabController.index;
      // 선택된 탭에 따라 실행할 동작을 수행합니다.
      switch (selectedTabIndex) {
        case 0: // '전체' 탭
          curTab = '전체';
          getPosts();
          break;
        case 1: // '정보' 탭
          curTab = '정보';
          getInfoPosts();
          break;
        case 2: // '질문' 탭
          curTab = '질문';
          getQuestionPosts();
          break;
        case 3: // '잡담' 탭
          curTab = '잡담';
          getTalkPosts();
          break;
      }
    }
  }

  // 전체글 가져와서 postList 구성
  getPosts() async {
    await db
        .collection('community')
        .orderBy('writeTime', descending: true)
        .limit(5)
        .get()
        .then((documentSnapshots) {
      lastVisible = documentSnapshots.docs[documentSnapshots.size - 1];
      postList.value =
          documentSnapshots.docs.map((e) => Post.fromMap(e.data())).toList();
    });
  }

  // 전체글 postList 더 가져오기 => 문제: index = 10n+5 일 때는 항상 실행. 거꾸로 올라갈 때도 실행. 수정해야함.
  getMorePosts() async {
    try {
      await db
          .collection('community')
          .orderBy('writeTime', descending: true)
          .startAfterDocument(lastVisible!)
          .limit(5)
          .get()
          .then((documentSnapshots) {
        lastVisible = documentSnapshots.docs[documentSnapshots.size - 1];
        postList.value!.addAll(
            documentSnapshots.docs.map((e) => Post.fromMap(e.data())).toList());
        postList.refresh();
      });
    } catch (e) {
      print('더 가져올 게시글이 없습니다.');
    }
  }

  // 정보탭 글만 가져와서 postList 구성

  getInfoPosts() async {
    await db
        .collection('community')
        .where('tag', isEqualTo: '정보')
        .orderBy('writeTime', descending: true)
        .limit(5)
        .get()
        .then((documentSnapshots) {
      lastVisible = documentSnapshots.docs[documentSnapshots.size - 1];
      postList.value =
          documentSnapshots.docs.map((e) => Post.fromMap(e.data())).toList();
      postList.refresh();
    });
  }

  // 정보탭 글만 더 가져와서 postList에 추가
  getMoreInfoPosts() async {
    try {
      await db
          .collection('community')
          .where('tag', isEqualTo: '정보')
          .orderBy('writeTime', descending: true)
          .startAfterDocument(lastVisible!)
          .limit(5)
          .get()
          .then((documentSnapshots) {
        lastVisible = documentSnapshots.docs[documentSnapshots.size - 1];
        postList.value!.addAll(
            documentSnapshots.docs.map((e) => Post.fromMap(e.data())).toList());
        postList.refresh();
      });
    } catch (e) {
      print('더 가져올 게시글이 없습니다.');
    }
  }

  // 질문탭 글만 가져와서 postList 구성
  getQuestionPosts() async {
    await db
        .collection('community')
        .where('tag', isEqualTo: '질문')
        .orderBy('writeTime', descending: true)
        .limit(5)
        .get()
        .then((documentSnapshots) {
      lastVisible = documentSnapshots.docs[documentSnapshots.size - 1];
      postList.value =
          documentSnapshots.docs.map((e) => Post.fromMap(e.data())).toList();
      postList.refresh();
    });
  }

  // 질문탭 글만 더 가져와서 postList에 추가
  getMoreQuestionPosts() async {
    try {
      await db
          .collection('community')
          .where('tag', isEqualTo: '질문')
          .orderBy('writeTime', descending: true)
          .startAfterDocument(lastVisible!)
          .limit(5)
          .get()
          .then((documentSnapshots) {
        lastVisible = documentSnapshots.docs[documentSnapshots.size - 1];
        postList.value!.addAll(
            documentSnapshots.docs.map((e) => Post.fromMap(e.data())).toList());
        postList.refresh();
      });
    } catch (e) {
      print('더 가져올 게시글이 없습니다.');
    }
  }

  // 잡담탭 글만 가져와서 postList 구성
  getTalkPosts() async {
    await db
        .collection('community')
        .where('tag', isEqualTo: '잡담')
        .orderBy('writeTime', descending: true)
        .limit(5)
        .get()
        .then((documentSnapshots) {
      lastVisible = documentSnapshots.docs[documentSnapshots.size - 1];
      postList.value =
          documentSnapshots.docs.map((e) => Post.fromMap(e.data())).toList();
      postList.refresh();
    });
  }

  // 잡담탭 글만 더 가져와서 postList에 추가
  getMoreTalkPosts() async {
    try {
      await db
          .collection('community')
          .where('tag', isEqualTo: '잡담')
          .orderBy('writeTime', descending: true)
          .startAfterDocument(lastVisible!)
          .limit(5)
          .get()
          .then((documentSnapshots) {
        lastVisible = documentSnapshots.docs[documentSnapshots.size - 1];
        postList.value!.addAll(
            documentSnapshots.docs.map((e) => Post.fromMap(e.data())).toList());
        postList.refresh();
      });
    } catch (e) {
      print('더 가져올 게시글이 없습니다.');
    }
  }

  // postCard 눌러 해당 postDetailPage로 이동하기
  goPost(Post post) async {
    // 조회수 증가
    if (FirebaseAuth.instance.currentUser!.uid != post.userInfo['uid']) {
      // 조회수 증가 대상 판별
      await db
          .collection('community')
          .doc(post.postId)
          .update({'views': FieldValue.increment(1)});
    } else {
      print('조회수 증가 대상 해당하지 않음');
    }

    // 해당 포스트의 댓글 가져오기
    await Get.find<CommunityController>().getComments(post);

    // 해당 포스트로 이동
    Get.to(PostDetailPage(post: post));
  }

// #### post_write_page controll
  RxString dropDownVal = '정보'.obs;
  RxList imgXfileList = [].obs;
  List imgDownloadUrlList =
      []; // List<Xfile> 형식을 firestore에 업로드 후, 다운로드url을 받아 imgDownloadUrlList에 넣어준 뒤, 해당 리스트를 DB > post의 field에 넣어주는 방식
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  // 사진 첨부 버튼 함수
  addPhoto() async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        imgXfileList.add(image);
      }
    } catch (e) {
      print(e);
    }
  }

  // 작성하기 버튼
  writePost() async {
    // 로딩중 시작, 함수 종료시 로딩중 끝
    Get.defaultDialog(
        backgroundColor: Colors.transparent,
        title: '업로드중입니다.',
        content: CircularProgressIndicator());

    // 2. 사진 url 포함한 데이터 db에 업로드(doc 생성)
    var res = await db.collection('community').add({
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
      'reportNum': 0,
      'commentsNum': 0
    });

    // xfileList의 이미지를 storage에 업로드 후 imgDownUrl list에 다운로드 url을 저장
    if (imgXfileList.isNotEmpty) {
      for (int i = 0; i < imgXfileList.length; i++) {
        var ref = await FirebaseStorage.instance
            .ref()
            .child('/community/post/images/${res.id}/image$i');
        var result = await ref.putFile(File(imgXfileList[i].path));
        var fileUrl = await ref.getDownloadURL();
        imgDownloadUrlList.add(fileUrl);
      }
    }

    // 이미지다운 리스트 포함된 정보 db에 업로드
    await db.collection('community').doc('${res.id}').set(
        {'postId': res.id, 'imgUrlList': imgDownloadUrlList},
        SetOptions(merge: true));

    var data = await db.collection('community').doc('${res.id}').get();
    Post post = Post.fromMap(data.data()!);

    // 작성 완료 후 작성자료 초기화
    imgXfileList.value = [];
    imgDownloadUrlList = [];
    titleController.text = '';
    contentController.text = '';

    // 작성 완료 후 작성한 페이지로 이동
    Get.back();
    Get.off(PostDetailPage(post: post)); // 왜 이전 write페이지가 스택에서 삭제가 안될까잉

    // 로딩중 끝
  }

  // #### post_detail_page controll
  TextEditingController commentTextController = TextEditingController();

  // 게시글 수정 1 - 기존 작성한 게시글을 post로 받아 게시글 작성페이지로 이동하는 함수
  moveToModifyPostPage(Post post) {
    //
    if (FirebaseAuth.instance.currentUser!.uid == post.userInfo['uid']) {
      Get.off(PostWritePage(post: post));
    } else {
      Get.snackbar('권한이 없습니다.', '글의 작성자와 현재 사용자가 일치하지 않습니다.');
    }
  }

  // 게시글 수정 2 - 수정한 게시글을 firebase에 업로드하고 수정된 게시글 detailPage로 이동하는 함수
  modifyPost(Post post) async {
    // 업로드 시작시 로딩인디케이터 화면에 띄움
    Get.defaultDialog(
        backgroundColor: Colors.transparent,
        title: '업로드중입니다.',
        content: CircularProgressIndicator());

    // 스토리지에 이미지 업로드 후 controller.imgDownloadUrlList에 추가
    if (imgXfileList.isNotEmpty) {
      var length = await FirebaseStorage.instance
          .ref()
          .child('/community/post/images/${post.postId}')
          .listAll();
      for (int i = 0; i < imgXfileList.length; i++) {
        var ref = await FirebaseStorage.instance.ref().child(
            '/community/post/images/${post.postId}/image${i + length.items.length}');
        var result = await ref.putFile(File(imgXfileList[i].path));
        var fileUrl = await ref.getDownloadURL();
        imgDownloadUrlList.add(fileUrl);
      }
    }
    // 파이어스토어에 수정된 게시글 업로드
    await db.collection('community').doc(post.postId).set({
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
    }, SetOptions(merge: true));

    var data = await db.collection('community').doc(post.postId).get();
    post = Post.fromMap(data.data()!);

    // 수정 완료 후 수정자료 초기화
    imgXfileList.value = [];
    imgDownloadUrlList = [];
    titleController.text = '';
    contentController.text = '';

    // 수정 완료 후 수정한 페이지로 이동
    Get.back();
    Get.off(PostDetailPage(post: post));
  }

  // ## 게시글 삭제
  removePost(Post post) async {
    if (FirebaseAuth.instance.currentUser!.uid == post.userInfo['uid']) {
      // 게시글 작성페이지로 이동
      await db.collection('community').doc(post.postId).delete();
      await getPosts();
      Get.back();
    } else {
      Get.snackbar('권한이 없습니다.', '글의 작성자와 현재 사용자가 일치하지 않습니다.');
    }
  }

  // ## comment 받아오기
  Rxn<List> commentList = Rxn([]);
  getComments(Post post) async {
    var res = await db
        .collection('community')
        .doc(post.postId)
        .collection('comments')
        .orderBy('writeTime')
        .get();
    commentList.value = res.docs;
  }

  // ## 댓글업로드
  writeComment({required String content, required Post post}) async {
    // 해당 post의 postId 이용하여 post doc > comments collection > comment doc 에 작성
    final docRef = db.collection('community').doc(post.postId);
    var res = await docRef.collection('comments').add({
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
    var data = await res.parent.get();
    await docRef
        .set({'commentsNum': data.docs.length}, SetOptions(merge: true));
  }

  // ## 댓글 삭제기능
  removeComment(Post post, String commentId, String authorUid) async {
    final docRef = db.collection('community').doc(post.postId);
    if (FirebaseAuth.instance.currentUser!.uid == authorUid) {
      await docRef.collection('comments').doc(commentId).delete();
      await docRef.update({'commentsNum': FieldValue.increment(-1)});
      getComments(post);
    } else {
      Get.snackbar('권한이 없습니다.', '댓글의 작성자와 현재 사용자가 일치하지 않습니다.');
    }
    getComments(post);
  }

  // ## 신고하기
  report() async {
    // 신고기능. 플레이스토어, 앱스토어 심사규정 확인 후 구체적 구현 계획할 것.
  }

  // 댓글 작성완료 버튼
  completeComment(Post post) async {
    Get.find<CommunityController>()
        .writeComment(content: commentTextController.text, post: post);
    await getComments(post);
    commentTextController.text = '';
    Get.back();
  }

// 시간 변환 함수
  String convertTime(Timestamp time) {
    DateTime writeTime = time.toDate();

    Duration difference = DateTime.now().difference(writeTime);

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
    communityTabController =
        TabController(length: communityTabs.length, vsync: this);
    communityTabController.addListener(_handleTabSelection);
    getPosts();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    communityTabController.dispose();
  }
}
