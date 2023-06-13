
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
  RxList<Journal> journalList = Get.find<JournalController>().journalList;
  RxList<Journal> galleryJournal = <Journal>[].obs;

  getGallery() {
    List<Journal> gallery = [];
    for (Journal journal in journalList) {
      log('for => ${journal}');
      if (plant.plantId == journal.plant.plantId) {
        log('plantId = journal.plantId => ${journal}');
        if (journal.imageUrl != null) {
          log('imageUrl != null => ${journal}');
          gallery.add(journal);
        }
      }
    }
    galleryJournal(gallery);
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
    super.onInit();
    getGallery();
  }
}
