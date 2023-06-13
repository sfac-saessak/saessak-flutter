
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saessak_flutter/view/page/schedule_journal/journal/journal_detail_page.dart';

import '../../../controller/plant/plant_controller.dart';
import '../../../controller/schedule_journal/journal_controller.dart';
import '../../../model/journal.dart';
import '../../../model/plant.dart';
import '../../../util/app_color.dart';
import 'add_plant_page.dart';

class PlantDetailPage extends StatelessWidget {
  const PlantDetailPage({Key? key, required this.plant}) : super(key: key);
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    print('플랜트 상세 : ${plant}');
    var controller = Get.find<PlantController>();
    var journalController = Get.find<JournalController>();
    
    RxList<Journal> journalList = journalController.journalList;
    List galleryJournal = [];
    for (Journal journal in journalList) {
      if (plant.plantId == journal.plant.plantId) {
        if (journal.imageUrl != null) {
          galleryJournal.add(journal);
        }
      }
    }
    
    return WillPopScope(
      onWillPop: () {
        journalController.onDelete();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${plant.name}'),
          centerTitle: true,
          backgroundColor: AppColor.white,
          foregroundColor: AppColor.black,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Get.off(() => AddPlantPage(plant: plant));
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                controller.deletePlant(plant.plantId!);
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
        body: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  child: CircleAvatar(
                    backgroundColor: AppColor.black20,
                    backgroundImage: plant.imageUrl != null
                        ? NetworkImage(plant.imageUrl!)
                        : null,
                    child: plant.imageUrl != null
                        ? null
                        : Icon(Icons.person, color: AppColor.white),
                  ),
                ),
                Column(
                  children: [
                    Text('${plant.name}'),
                    Text('${plant.species}'),
                    Row(
                      children: [
                        Text(
                            '${DateFormat("yyyy-MM-dd").format(plant.plantingDate.toDate())}'),
                        Text(
                            '(D+${controller.getDaysSincePlanting(plant.plantingDate)})'),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Text('급수 주기:'),
                Text('${plant.wateringCycle}'),
              ],
            ),
            Row(
              children: [
                Text('최적 온도:'),
                Text('${plant.optimalTemperature}'),
              ],
            ),
            Row(
              children: [
                Text('빛 요구도:'),
                Text('${plant.lightRequirement}'),
              ],
            ),
            Row(
              children: [
                Text('메모:'),
                Text('${plant.memo}'),
              ],
            ),

            Text('갤러리'),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                ),
                itemCount: galleryJournal.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => JournalDetailPage(journal: galleryJournal[index]));
                    },
                    child: Image.network(galleryJournal[index].imageUrl),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
