import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saessak_flutter/view/page/plant/plant_detail_page.dart';
import '../../model/plant.dart';
import '../../model/tree.dart';
import '../../service/db_service.dart';

class PlantController extends GetxController {
  User get user => FirebaseAuth.instance.currentUser!;
  TextEditingController nameController = TextEditingController(); // 애칭
  TextEditingController speciesController = TextEditingController(); // 종
  TextEditingController wateringCycleController =
      TextEditingController(); // 급수 주기
  TextEditingController optimalTemperatureController =
      TextEditingController(); // 최적 온도
  TextEditingController lightRequirementController =
      TextEditingController(); // 빛 요구도
  TextEditingController memoController = TextEditingController(); // 메모

  Rx<Timestamp?> plantingDate = Rx<Timestamp?>(null); // 심은 날짜
  Rxn<File> selectedImage = Rxn(); // 추가한 사진
  RxBool isLoading = false.obs; // 로딩중 상태

  RxList<Plant> plantList = <Plant>[].obs; // 식물 리스트
  RxList<Plant> reversedPlantList = <Plant>[].obs; // 식물 리스트
  String forestBackground = 'assets/images/forest_background_day.png';  // 숲 배경
  RxList<Tree> treeList = <Tree>[].obs;    // 나무 리스트


  // 이미지 선택
  void selectImage() async {
    var picker = ImagePicker();
    var res = await picker.pickImage(source: ImageSource.gallery);
    if (res != null) {
      selectedImage(File(res.path));
    }
  }

  // 심은 날짜 선택
  void selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: '심은 날짜',
      cancelText: '취소',
      confirmText: '선택',
    );

    if (pickedDate != null) {
      plantingDate.value = Timestamp.fromDate(pickedDate);
    }
  }

  // 식물 가져오기
  getPlants() async {
    isLoading(true);
    QuerySnapshot snapshot = await DBService(uid: user.uid).getPlants();
    plantList(snapshot.docs
        .map((doc) => Plant.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
    reversedPlantList(plantList.reversed.toList());
    getTrees();
    isLoading(false);
  }

  // 식물 추가
  addPlant() async {
    if (nameController.text != '' &&
        speciesController.text != '' &&
        optimalTemperatureController.text != '' &&
        wateringCycleController.text != '' &&
        lightRequirementController.text != '') {
      var imageUrl;
      isLoading(true);
      if (selectedImage.value != null) {
        var ref = FirebaseStorage.instance
            .ref('plants/${user.uid}/${DateTime.now()}');
        await ref.putFile(selectedImage.value!);
        var downloadUrl = await ref.getDownloadURL();
        imageUrl = downloadUrl;
      }

      Plant plant = Plant(
        name: nameController.text,
        species: speciesController.text,
        plantingDate: plantingDate.value!,
        optimalTemperature: optimalTemperatureController.text,
        wateringCycle: int.tryParse(wateringCycleController.text)!,
        lightRequirement: lightRequirementController.text,
        createdAt: Timestamp.now(),
        memo: memoController.text,
        imageUrl: imageUrl,
      );
      await DBService(uid: user.uid).addPlant(plant);
      isLoading(false);

      Get.back();
      getPlants();
      Get.snackbar('식물', '등록 완');
    } else {
      Get.snackbar('등록 실패', '식물 정보를 정확히 입력해주세요.');
    }
  }

  // 식물 삭제
  deletePlant(String plantId) async {
    isLoading(true);
    await DBService(uid: user.uid).deletePlant(plantId);
    isLoading(false);
    Get.back();
    getPlants();
  }

  // 식물 수정
  editPlant(Plant plant) async {
    final plantDocRef = DBService()
        .plantsCollection
        .doc(user.uid)
        .collection("plant")
        .doc(plant.plantId);

    if (selectedImage.value != null) {
      await FirebaseStorage.instance.refFromURL(plant.imageUrl!).delete();
      var ref =
          FirebaseStorage.instance.ref('plants/${user.uid}/${DateTime.now()}');
      await ref.putFile(selectedImage.value!);
      var downloadUrl = await ref.getDownloadURL();
      plant.imageUrl = downloadUrl;
    }

    await plantDocRef.update({
      'name': nameController.text,
      'species': speciesController.text,
      'plantingDate': plantingDate.value!,
      'optimalTemperature': optimalTemperatureController.text,
      'wateringCycle': int.tryParse(wateringCycleController.text)!,
      'lightRequirement': lightRequirementController.text,
      'memo': memoController.text,
      'imageUrl': plant.imageUrl,
    });

    var data = await plantDocRef.get();

    plant = Plant.fromMap(data.data()!);

    Get.off(PlantDetailPage(plant: plant), arguments: [plant]);
    getPlants();
  }

  // 심은지 며칠
  int getDaysSincePlanting(Timestamp time) {
    DateTime plantingDate = time.toDate();
    int daysSincePlanting = DateTime.now().difference(plantingDate).inDays;
    return daysSincePlanting;
  }

  // 나무 가져오기
  Future<void> getTrees() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('forest')
          .doc(user.uid)
          .get();

      final data = snapshot.data();
      if (data != null && data.containsKey('tree')) {
        final treeList = List<Map<String, dynamic>>.from(data['tree']);
        this.treeList(treeList.map((treeMap) => Tree.fromMap(treeMap)).toList());
      } else {
        this.treeList([]);
      }
    } catch (e) {
      print('Error fetching trees: $e');
    }
  }


  @override
  void onInit() {
    super.onInit();
    getPlants();
    getTrees();

    int currentHour = DateTime.now().hour;
    if (currentHour >= 6 && currentHour < 18) {
      forestBackground = 'assets/images/forest_background_day.png';
    } else {
      forestBackground = 'assets/images/forest_background_night.png';
    }
  }
}
