import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saessak_flutter/view/page/plant/plant_detail_page.dart';

import '../../model/plant.dart';
import '../../service/db_service.dart';

class PlantController extends GetxController with GetTickerProviderStateMixin {
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
    isLoading(false);
  }

  // 식물 추가
  addPlant() async {
    var imageUrl;
    isLoading(true);
    if (selectedImage.value != null) {
      var ref =
          FirebaseStorage.instance.ref('plants/${user.uid}/${DateTime.now()}');
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

    nameController.clear();
    speciesController.clear();
    wateringCycleController.clear();
    optimalTemperatureController.clear();
    lightRequirementController.clear();
    memoController.clear();
    plantingDate(null);
    selectedImage(null);
    Get.back();
    getPlants();
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

    nameController.clear();
    speciesController.clear();
    wateringCycleController.clear();
    optimalTemperatureController.clear();
    lightRequirementController.clear();
    memoController.clear();
    plantingDate(null);
    selectedImage(null);

    Get.off(PlantDetailPage(plant: plant));
    getPlants();
  }

  // 심은지 며칠
  int getDaysSincePlanting(Timestamp time) {
    DateTime plantingDate = time.toDate();
    int daysSincePlanting = DateTime.now().difference(plantingDate).inDays;
    return daysSincePlanting;
  }

  // 갤러리 가져오기
  getGallery(String plantId) {}

// ##### test
  late final AnimationController controller_a = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();
  late final AnimationController controller_b = AnimationController(
    duration: const Duration(seconds: 30),
    vsync: this,
  )..repeat();

  @override
  void onInit() {
    super.onInit();
    getPlants();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    controller_a.dispose();
    controller_b.dispose();
  }
}
