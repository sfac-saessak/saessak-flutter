
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/schedule_journal/journal_controller.dart';
import '../../page/schedule_journal/journal/add_journal_page.dart';
import '../../widget/journal_tile.dart';

class JournalScreen extends GetView<JournalController> {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          ElevatedButton(
            onPressed: (){
              if (controller.plantList.length <= 0) {
                Get.snackbar('식물없음', '식물추가부터해라');
              } else {
                Get.to(() => AddJournalPage());
              }
            },
            child: Text('일지 등록'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.journalList.length,
              itemBuilder: (context, index) {
                return JournalTile(journal: controller.journalList[index]);
              }
            ),
          )
        ],
      ),
    );
  }
}
