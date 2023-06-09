
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  RxList<Journal> journalList = <Journal>[].obs;    // 일지 리스트

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
      writeTime: Timestamp.now(),
      bookmark: false,
      content: contentController.text,
      imageUrl: imageUrl,
    );

    await DBService(uid: user.uid).addJournal(journal);
    isLoading(false);

    contentController.clear();
    selectedImage(null);
    readJournal();
    Get.back();
  }

  // 일지 가져오기
  void readJournal() async {
    isLoading(true);
    QuerySnapshot snapshot = await DBService(uid: user.uid).readJournal();

    var futureJournals = snapshot.docs.map((doc) async {
      var journal = doc.data() as Map<String, dynamic>;
      var plantInfo = await getPlantById(journal['plant']);
      var plant = Plant.fromMap(plantInfo);
      return Journal(
        plant: plant,
        writeTime: journal['writeTime'],
        bookmark: journal['bookmark'],
        content: journal['content'],
        imageUrl: journal['imageUrl'],
      );
    }).toList();

    var journals = await Future.wait(futureJournals);
    journalList(journals);

    log('journalList => ${journalList}');
    isLoading(false);
  }

  // 식물id로 식물 정보 가져오기
  Future<Map<String, dynamic>> getPlantById(String plantId) async {
    var plantInfo = await DBService(uid: user.uid).getPlantById(plantId);
    return plantInfo;
  }

  @override
  void onInit() {
    super.onInit();
    readJournal();
    log('journalList => ${journalList}');
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
  }
}
