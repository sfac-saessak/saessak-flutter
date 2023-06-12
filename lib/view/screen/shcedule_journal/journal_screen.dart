
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/schedule_journal/journal_controller.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';
import '../../page/schedule_journal/journal/add_journal_page.dart';
import '../../page/schedule_journal/journal/journal_bookmark_page.dart';
import '../../widget/journal_tile.dart';

class JournalScreen extends GetView<JournalController> {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: AppColor.black10,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){
                    if (controller.plantList.length <= 0) {
                      Get.snackbar('식물없음', '식물추가부터해라');
                    } else {
                      Get.to(() => AddJournalPage(journal: null));
                    }
                  },
                  child: Text('일지 등록'),
                ),
                ElevatedButton(
                  onPressed: (){
                    Get.to(() => JournalBookmarkPage());
                  },
                  child: Text('북마크'),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.journalList.length,
                itemBuilder: (context, index) {
                  final journal = controller.journalList[index];
                  final currentJournalDate = journal.writeTime.toDate();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0 ||
                          currentJournalDate.year != controller.journalList[index - 1].writeTime.toDate().year ||
                          currentJournalDate.month != controller.journalList[index - 1].writeTime.toDate().month ||
                          currentJournalDate.day != controller.journalList[index - 1].writeTime.toDate().day)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text(
                            '${currentJournalDate.year}.${currentJournalDate.month}.${currentJournalDate.day}',
                            style: AppTextStyle.body3_b(),
                          ),
                        ),
                      JournalTile(journal: journal),
                    ],
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
