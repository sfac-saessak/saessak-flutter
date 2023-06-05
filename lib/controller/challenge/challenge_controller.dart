import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:saessak_flutter/service/db_service.dart';

import '../../model/challenge.dart';
import '../../view/screen/challenge/all_challenge_screen.dart';
import '../../view/screen/challenge/joined_challenge_screen.dart';

class ChallengeController extends GetxController with GetSingleTickerProviderStateMixin {
  User get user => FirebaseAuth.instance.currentUser!;
  late TabController tabController;         // 탭바 컨트롤러
  RxBool isLoading = false.obs;             // 로딩중 상태

  RefreshController allRefreshController = RefreshController(initialRefresh: false);      // 전체 챌린지 새로고침 컨트롤러
  RefreshController joinedRefreshController = RefreshController(initialRefresh: false);   // 참여중 챌린지 새로고침 컨트롤러
  TextEditingController plantController = TextEditingController();    // 식물 컨트롤러
  TextEditingController titleController = TextEditingController();    // 제목 컨트롤러
  TextEditingController contentController = TextEditingController();  // 내용 컨트롤러
  TextEditingController searchController = TextEditingController();   // 검색 컨트롤러

  Rxn<int> selectedMemberLimit = Rxn();     // 인원수 선택값
  Rxn<File> selectedImage = Rxn();          // 추가한 사진
  Rx<Timestamp?> startDate = Rx<Timestamp?>(null);  // 챌린지 시작 날짜
  Rx<Timestamp?> endDate = Rx<Timestamp?>(null);    // 챌린지 끝 날짜

  RxList allChallengeList = [].obs;         // 전체 챌린지 리스트
  RxList joinedChallengeList = [].obs;      // 참여중인 챌린지 리스트
  RxList searchResultList = [].obs;         // 챌린지 검색결과 리스트

  final List<Tab> tabs = <Tab>[             // 탭
    Tab(text: '참여중'),
    Tab(text: '전체'),
  ];

  final List<Widget> tabViews = <Widget>[   // 탭 뷰
    JoinedChallengeScreen(),
    AllChallengeScreen(),
  ];

  List<String> memberLimitList = [          // 인원수 드롭다운 리스트
    '전체',
    for (int i = 1; i <= 20; i++) i.toString(),
  ];

  // 인원수 선택
  void setSelectedMemberLimit(int? value) {
    selectedMemberLimit(value);
  }

  // 기간 선택
  void selectDate(bool isStartDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      helpText: isStartDate ? '시작 날짜' : '종료 날짜',
      cancelText: '취소',
      confirmText: '선택',
    );

    if (pickedDate != null) {
      if (isStartDate) {
        startDate.value = Timestamp.fromDate(pickedDate);
      } else {
        endDate.value = Timestamp.fromDate(pickedDate);
      }
    }
  }

  // 이미지 선택
  void selectImage() async {
    var picker = ImagePicker();
    var res = await picker.pickImage(source: ImageSource.gallery);
    if (res != null) {
      selectedImage(File(res.path));
    }
  }

  // 챌린지 추가
  createChallenge() async {
    var imageUrl;
    isLoading(true);
    if (selectedImage.value != null) {
      var ref = FirebaseStorage.instance.ref('challenge/${user.uid}/${DateTime.now()}');
      await ref.putFile(selectedImage.value!);
      var downloadUrl = await ref.getDownloadURL();
      imageUrl = downloadUrl;
    }

    Challenge challenge = Challenge(
      plant: plantController.text,
      admin: user.uid,
      title: titleController.text,
      content: contentController.text,
      createdAt: Timestamp.now(),
      startDate: startDate.value!,
      endDate: endDate.value!,
      memberLimit: selectedMemberLimit.value,
      imageUrl: imageUrl,
    );

    await DBService(uid: user.uid).createChallenge(challenge);
    isLoading(false);
    Get.back();
  }

  // 전체 챌린지 가져오기
  getChallenge() async {
    isLoading(true);
    allChallengeList([]);
    QuerySnapshot snapshot = await DBService().getAllChallenge();
    allChallengeList(snapshot.docs.map((doc) => Challenge.fromMap(doc.data() as Map<String, dynamic>)).toList());
    log('${allChallengeList}');
    isLoading(false);
  }

  // 참여중인 챌린지 가져오기
  getJoinedChallenges() async {
    isLoading(true);
    var joinedChallengeIdList = await DBService(uid: user.uid).getJoinedChallenges();
    var challenges = [];
    if (joinedChallengeIdList.length > 0) {
      for (var joinedChallengeId in joinedChallengeIdList) {
        var challenge = await DBService().challengeCollection.doc(joinedChallengeId).get();
        challenges.add(Challenge.fromMap(challenge.data() as Map<String, dynamic>));
      }
      joinedChallengeList(challenges);
      log('joinedChallengeList ${joinedChallengeList}');
    }
    isLoading(false);
  }

  // 전체 챌린지 새로고침
  void allChallengeRefresh() async {
    await getChallenge();
    allRefreshController.refreshCompleted();
  }

  // 참여중 챌린지 새로고침
  void joinedChallengeRefresh() async {
    await getJoinedChallenges();
    joinedRefreshController.refreshCompleted();
  }

  // 챌린지 검색
  void searchChallenge() async {
    isLoading(true);
    var res = await DBService().searchChallengeByPlant(searchController.text);
    List<dynamic> snapshotData = res.docs.map((doc) => doc.data()).toList();
    searchResultList(snapshotData.map((e) => Challenge.fromMap(e)).toList());
    isLoading(false);
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    getChallenge();
    getJoinedChallenges();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
    allRefreshController.dispose();
    joinedRefreshController.dispose();
  }
}