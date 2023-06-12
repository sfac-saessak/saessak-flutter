
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/follow/friend_detail_controller.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';
import '../../widget/journal_tile.dart';

class FriendJournalScreen extends GetView<FriendDetailController> {
  const FriendJournalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.black10,
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.only(top: 10),
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
        ),
      ),
    );
  }
}
