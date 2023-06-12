
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/schedule_journal/journal_controller.dart';
import '../../../../util/app_color.dart';
import '../../../../util/app_text_style.dart';
import '../../../widget/journal_tile.dart';

class JournalBookmarkPage extends GetView<JournalController> {
  const JournalBookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black10,
      appBar: AppBar(
        title: Text('북마크', style: AppTextStyle.body2_m()),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.bookmarkList.length,
          itemBuilder: (context, index) {
            final journal = controller.bookmarkList[index];
            final currentJournalDate = journal.writeTime.toDate();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index == 0 ||
                    currentJournalDate.year != controller.bookmarkList[index - 1].writeTime.toDate().year ||
                    currentJournalDate.month != controller.bookmarkList[index - 1].writeTime.toDate().month ||
                    currentJournalDate.day != controller.bookmarkList[index - 1].writeTime.toDate().day)
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
      ),
    );
  }
}

