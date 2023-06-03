
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saessak_flutter/service/db_service.dart';

import '../../model/challenge.dart';
import '../../view/screen/challenge/all_challenge_screen.dart';
import '../../view/screen/challenge/joined_challenge_screen.dart';

class ChallengeController extends GetxController with GetSingleTickerProviderStateMixin {
  User get user => FirebaseAuth.instance.currentUser!;
  late TabController tabController;         // 탭바 컨트롤러
  RxBool isLoading = false.obs;             // 로딩중 상태

  TextEditingController plantController = TextEditingController();    // 식물 컨트롤러
  TextEditingController titleController = TextEditingController();    // 제목 컨트롤러
  TextEditingController contentController = TextEditingController();  // 내용 컨트롤러

  Rxn<int> selectedMemberLimit = Rxn();     // 인원수 선택값
  Rxn<File> selectedImage = Rxn();          // 추가한 사진
  Rx<DateTime?> startDate = Rx<DateTime?>(null);  // 챌린지 시작 날짜
  Rx<DateTime?> endDate = Rx<DateTime?>(null);    // 챌린지 끝 날짜

  final List<Tab> tabs = <Tab>[             // 탭
    Tab(text: '참여중인 챌린지'),
    Tab(text: '전체 챌린지'),
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
        startDate.value = pickedDate;
      } else {
        endDate.value = pickedDate;
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
      var ref = FirebaseStorage.instance.ref('diary/${user.uid}/${DateTime.now()}');
      await ref.putFile(selectedImage.value!);
      var downloadUrl = await ref.getDownloadURL();
      imageUrl = downloadUrl;
    }

    Challenge challenge = Challenge(
      plant: plantController.text,
      admin: user.uid,
      title: titleController.text,
      content: contentController.text,
      createdAt: DateTime.now(),
      startDate: startDate.value!,
      endDate: endDate.value!,
      memberLimit: selectedMemberLimit.value,
      imageUrl: imageUrl,
    );

    await DBService(uid: user.uid).createChallenge(challenge);

    isLoading(false);
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }
}
