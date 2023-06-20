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
import '../../model/user_model.dart';
import '../../view/page/challenge/challenge_detail_page.dart';
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

  Rx<Timestamp?> startDate = Rx<Timestamp?>(null);  // 챌린지 시작 날짜
  Rx<Timestamp?> endDate = Rx<Timestamp?>(null);    // 챌린지 끝 날짜
  Rxn<int> selectedMemberLimit = Rxn();     // 인원수 선택값
  Rxn<File> selectedImage = Rxn();          // 추가한 사진

  RxList allChallengeList = [].obs;         // 전체 챌린지 리스트
  RxList joinedChallengeList = [].obs;      // 참여중인 챌린지 리스트
  RxList searchResultList = [].obs;         // 챌린지 검색결과 리스트
  RxList filteredJoinChallengeList = [].obs;   // 참여중인 챌린지 진행/종료 필터링 리스트
  RxList filteredAllChallengeList = [].obs;    // 전체 챌린지 모집중/모집종료 필터링 리스트

  List<String> joinedChallengeFilter = ['전체', '진행중', '종료'];
  List<String> allChallengeFilter = ['전체', '모집중', '모집마감'];

  RxInt joinedFilterSelectedIdx = 0.obs;    // 참여중인 챌린지 필터링 선택값
  RxInt allFilterSelectedIdx = 0.obs;       // 전체 챌린지 필터링 선택값

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

    var userInfo = await getUserInfoById(user.uid);
    var userModel = UserModel.fromMap(userInfo);

    Challenge challenge = Challenge(
      plant: plantController.text,
      admin: userModel,
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
    updateAllChallenge();
    getJoinedChallenges();
    Get.back();
  }

  // 전체 챌린지 업데이트
  updateAllChallenge() async {
    QuerySnapshot snapshot = await DBService().getAllChallenge();
    var futureChallenges = snapshot.docs.map((doc) async {
      var challengeData = doc.data() as Map<String, dynamic>;
      var userInfo = await getUserInfoById(challengeData['admin']);
      var admin = UserModel.fromMap(userInfo);
      var challenge = Challenge.fromMap(challengeData, admin);

      challenge.recruitmentStatus = getDeadline(challenge.startDate) <= 0;

      return challenge;
    });

    var challenges = await Future.wait(futureChallenges);
    allChallengeList(challenges);
  }

  // 참여중인 챌린지 가져오기
  getJoinedChallenges() async {
    var startTime = DateTime.now(); // 코드 실행 시작 시간 기록
    isLoading(true);

    var joinedChallengeIdList = await DBService(uid: user.uid).getJoinedChallenges();

    if (joinedChallengeIdList.isNotEmpty) {
      var challenges = <Challenge>[];
      var challengeFutures = <Future<QuerySnapshot>>[];

      // 단일 쿼리로 모든 참여 중인 챌린지 데이터 가져오기
      challengeFutures.add(DBService().challengeCollection.where('challengeId', whereIn: joinedChallengeIdList).get());

      var challengeSnapshots = await Future.wait(challengeFutures);

      // 첫 번째 쿼리 결과를 사용하여 챌린지 데이터 추출
      var joinedChallengesData = challengeSnapshots[0].docs.map((snapshot) => snapshot.data() as Map<String, dynamic>).toList();

      for (var challengeData in joinedChallengesData) {
        var userInfo = await getUserInfoById(challengeData['admin']);
        var admin = UserModel.fromMap(userInfo);

        var challenge = Challenge.fromMap(challengeData, admin);

        challenge.progressStatus = DateTime.now().isBefore(challenge.endDate.toDate());

        challenges.add(challenge);
      }

      challenges.sort((a, b) => b.recentMessageTime!.compareTo(a.recentMessageTime!));

      joinedChallengeList(challenges);
      log('joinedChallengeList $joinedChallengeList');
    }

    isLoading(false);

    var endTime = DateTime.now();
    var executionTime = endTime.difference(startTime);
    log('실행속도: ${executionTime.inMilliseconds} milliseconds');
  }

  // 전체 챌린지 새로고침
  void allChallengeRefresh() async {
    await updateAllChallenge();
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

    var futureChallenges = snapshotData.map((e) async {
      var userInfo = await getUserInfoById(e['admin']);
      var admin = UserModel.fromMap(userInfo);
      var challenge = Challenge.fromMap(e, admin);

      challenge.progressStatus = DateTime.now().isBefore(challenge.endDate.toDate());
      challenge.recruitmentStatus = getDeadline(challenge.startDate) <= 0;

      return challenge;
    }).toList();

    var challenges = await Future.wait(futureChallenges);

    searchResultList(challenges);
    isLoading(false);
  }

  // 챌린지 참가
  void joinChallenge(String challengeId) {
    DBService(uid: user.uid).joinChallenge(challengeId);
    getJoinedChallenges();
    Get.back();
  }

  // 시간 변환
  String convertTime(Timestamp time) {
    DateTime recentMessageTime = time.toDate();
    Duration difference = DateTime.now().difference(recentMessageTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '지금';
    }
  }

  // 모집 마감 디데이 구하기
  int getDeadline(Timestamp time) {
    DateTime deadline = time.toDate();
    Duration difference = DateTime.now().difference(deadline);
    return difference.inDays;
  }

  // 챌린지 수정
  editChallenge(Challenge challenge) async {

    final challengeDocRef = DBService().challengeCollection.doc(challenge.challengeId);

    if (challenge.imageUrl != null) {
      await FirebaseStorage.instance.refFromURL(challenge.imageUrl!).delete();
    }

    if (selectedImage.value != null) {
      var ref = FirebaseStorage.instance.ref('challenge/${user.uid}/${DateTime.now()}');
      await ref.putFile(selectedImage.value!);
      var downloadUrl = await ref.getDownloadURL();
      challenge.imageUrl = downloadUrl;
    }

    await challengeDocRef.update({
      'title': titleController.text,
      'content': contentController.text,
      'image': challenge.imageUrl,
    });

    var data = await FirebaseFirestore.instance
      .collection('challenges')
      .doc(challenge.challengeId)
      .get();

    var userInfo = await getUserInfoById(data.data()!['admin']);
    var admin = UserModel.fromMap(userInfo);

    challenge = Challenge.fromMap(data.data()!, admin);

    challenge.progressStatus = DateTime.now().isBefore(challenge.endDate.toDate());
    challenge.recruitmentStatus = getDeadline(challenge.startDate) <= 0;

    selectedImage.value = null;
    titleController.text = '';
    contentController.text = '';

    Get.off(ChallengeDetailPage(challenge: challenge));
  }

  // uid로 유저 정보 가져오기
  Future<Map<String, dynamic>> getUserInfoById(String uid) async {
    var userInfo = await DBService().getUserInfoById(uid);
    return userInfo;
  }

  // 참여중인 챌린지 필터링
  filterJoinChallenge(String status) {
    List<Challenge> filteredChallengeList = [];
    for (Challenge challenge in joinedChallengeList) {
      if (status == '진행중') {
        if (challenge.progressStatus!) {
          filteredChallengeList.add(challenge);
        }
      } else {
        if (!challenge.progressStatus!) {
          filteredChallengeList.add(challenge);
        }
      }
    }
    this.filteredJoinChallengeList(filteredChallengeList);
  }

  // 전체 챌린지 필터링
  filterAllChallenge(String status) {
    List<Challenge> filteredChallengeList = [];
    for (Challenge challenge in allChallengeList) {
      if (status == '모집중') {
        if (challenge.recruitmentStatus!) {
          filteredChallengeList.add(challenge);
        }
      } else {
        if (!challenge.recruitmentStatus!) {
          filteredChallengeList.add(challenge);
        }
      }
    }
    this.filteredAllChallengeList(filteredChallengeList);
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    updateAllChallenge();
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
