
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saessak_flutter/view/page/schedule_journal/journal/journal_detail_page.dart';

import '../../model/journal.dart';
import '../../model/plant.dart';
import '../../service/db_service.dart';
import '../plant/plant_controller.dart';

class JournalController extends GetxController {
  User get user => FirebaseAuth.instance.currentUser!;

  TextEditingController contentController = TextEditingController();

  RxList<Plant> plantList = Get.find<PlantController>().plantList;   // 식물 리스트
  Rxn<File> selectedImage = Rxn();                  // 추가한 사진
  RxBool isLoading = false.obs;                     // 로딩중 상태
  late Rx<Plant> selectedPlant;                     // 선택된 식물
  RxList<Journal> journalList = <Journal>[].obs;    // 전체 일지 리스트
  RxList<Journal> filteredJournalList = <Journal>[].obs;    // 필터링된 일지 리스트
  RxList<Journal> bookmarkList = <Journal>[].obs;   // 북마크 리스트
  RxList<Plant> journalPlantList = <Plant>[].obs;   // 필터링 식물 리스트
  RxInt selectedIdx = 0.obs;                        // 필터링 식물 리스트

  // 이미지 선택
  void selectImage() async {
    var picker = ImagePicker();
    var res = await picker.pickImage(source: ImageSource.gallery);
    if (res != null) {
      selectedImage(File(res.path));
    }
  }

  // 일지 추가
  addJournal() async {
    var imageUrl;
    isLoading(true);
    if (selectedImage.value != null) {
      var ref = FirebaseStorage.instance.ref('journals/${user.uid}/${DateTime.now()}');
      await ref.putFile(selectedImage.value!);
      var downloadUrl = await ref.getDownloadURL();
      imageUrl = downloadUrl;
    }

    Journal journal = Journal(
      plant: selectedPlant.value,
      uid: user.uid,
      writeTime: Timestamp.now(),
      bookmark: false.obs,
      content: contentController.text,
      imageUrl: imageUrl,
    );

    await DBService(uid: user.uid).addJournal(journal);
    isLoading(false);

    contentController.clear();
    selectedImage(null);
    // readJournal();
    Get.back();
  }

  // 일지 수정
  editJournal(Journal journal) async {
    log('journalId => ${journal.journalId}');
    final journalDocRef = DBService().journalsCollection.doc(user.uid).collection("journal").doc(journal.journalId);

    if (selectedImage.value != null) {
      await FirebaseStorage.instance.refFromURL(journal.imageUrl!).delete();
      var ref = FirebaseStorage.instance.ref('journals/${user.uid}/${DateTime.now()}');
      await ref.putFile(selectedImage.value!);
      var downloadUrl = await ref.getDownloadURL();
      journal.imageUrl = downloadUrl;
    }

    await journalDocRef.update({
      'content': contentController.text,
      'imageUrl': journal.imageUrl,
    });

    var data = await journalDocRef.get();

    var journalData = data.data() as Map<String, dynamic>;
    var plantInfo = await getPlantById(journalData['plant']);
    var plant = Plant.fromMap(plantInfo);
    journal = Journal(
      plant: plant,
      journalId: journalData['journalId'],
      uid: journalData['uid'],
      writeTime: journalData['writeTime'],
      bookmark: journalData['bookmark'],
      content: journalData['content'],
      imageUrl: journalData['imageUrl'],
    );

    contentController.clear();
    selectedImage(null);

    Get.off(JournalDetailPage(journal: journal));
    // readJournal();
  }

  // 일지 삭제
  deleteJournal(String journalId) async {
    isLoading(true);
    await DBService(uid: user.uid).deleteJournal(journalId);
    isLoading(false);
    Get.back();
    // readJournal();
  }

  // 식물id로 식물 정보 가져오기
  Future<Map<String, dynamic>> getPlantById(String plantId) async {
    var plantInfo = await DBService().getPlantById(user.uid, plantId);
    return plantInfo;
  }

  // 북마크/북마크 취소
  toggleBookmark(String journalId) async {
    await DBService(uid: user.uid).toggleBookmark(journalId);
    getBookmark();
  }

  // 북마크 리스트 가져오기
  getBookmark() {
    List<Journal> bookmarkList = [];
    for (Journal journal in journalList) {
      if (journal.bookmark.value) bookmarkList.add(journal);
    }
    this.bookmarkList(bookmarkList);
  }

  // 일지 가져오기
  Future readJournal() async {
    isLoading(true);
    QuerySnapshot snapshot = await DBService().readJournal(user.uid);

    var futureJournals = snapshot.docs.map((doc) async {
      var journal = doc.data() as Map<String, dynamic>;
      var plantInfo = await getPlantById(journal['plant']);
      var plant = Plant.fromMap(plantInfo);
      bool bookmark = journal['bookmark'];
      return Journal(
        plant: plant,
        journalId: journal['journalId'],
        uid: journal['uid'],
        writeTime: journal['writeTime'],
        bookmark: bookmark.obs,
        content: journal['content'],
        imageUrl: journal['imageUrl'],
      );
    }).toList();

    var journals = await Future.wait(futureJournals);
    journalList(journals);

    List<Plant> journalPlantList = [];
    for (Journal journal in journals) {
      bool isDuplicate = false;
      for (Plant plant in journalPlantList) {
        if (journal.plant == plant) {
          isDuplicate = true;
          break;
        }
      }
      if (!isDuplicate) {
        journalPlantList.add(journal.plant);
      }
    }
    this.journalPlantList(journalPlantList);
    log('journalPlantList => ${journalPlantList}');

    getBookmark();
    isLoading(false);
  }

  // 식물별 필터링
  filterJournalsByPlant(String plantId) {
    List<Journal> filteredJournalList = [];
    for (var journal in journalList) {
      if (journal.plant.plantId == plantId) {
        filteredJournalList.add(journal);
      }
    }
    this.filteredJournalList(filteredJournalList);
  }

  @override
  void onInit() {
    super.onInit();
    readJournal();
    try {
      selectedPlant = plantList[0].obs;
    } catch (e) {
      log('식물 없음');
    }
    ever(plantList, (_) {
      if (plantList.length <= 0) {
        return;
      } else {
        selectedPlant = plantList[0].obs;
      }
    });
    DBService().journalsCollection
        .doc(user.uid).collection("journal")
        .orderBy('writeTime', descending: true)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        readJournal();
      } else {
        journalList([]);
      }
    });
    update();
  }
}
