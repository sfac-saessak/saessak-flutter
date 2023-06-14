
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../model/journal.dart';
import '../../model/plant.dart';
import '../schedule_journal/journal_controller.dart';
import 'plant_controller.dart';

class PlantDetailController extends GetxController {
  Plant plant = Get.arguments[0];

  var plantController = Get.find<PlantController>();
  var journalController = Get.find<JournalController>();
  RxList<Journal> galleryJournal = <Journal>[].obs;
  RxBool isLoading = false.obs;                     // 로딩중 상태

  getGallery() async {
    isLoading(true);
    RxList<Journal> journalList = journalController.journalList;
    await journalController.readJournal();
    List<Journal> gallery = [];
    for (Journal journal in journalList) {
      if (plant.plantId == journal.plant.plantId) {
        if (journal.imageUrl != null) {
          gallery.add(journal);
        }
      }
    }
    galleryJournal(gallery);
    isLoading(false);
    log('gallery => ${galleryJournal}');
  }

  deletePlant() => plantController.deletePlant(plant.plantId!);

  // 심은지 며칠
  int getDaysSincePlanting(Timestamp time) {
    DateTime plantingDate = time.toDate();
    int daysSincePlanting = DateTime.now().difference(plantingDate).inDays;
    return daysSincePlanting;
  }

  @override
  void onInit() {
    getGallery();
    super.onInit();
  }

  @override
  void onClose() {
    log('onClose');
    super.onClose();
  }
}
