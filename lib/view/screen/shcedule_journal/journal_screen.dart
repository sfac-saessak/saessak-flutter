
import 'dart:developer';

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
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onPressed: (){
                        if (controller.plantList.length <= 0) {
                          Get.snackbar('식물없음', '식물추가부터해라');
                        } else {
                          Get.to(() => AddJournalPage(journal: null));
                        }
                      },
                      child: Text('일지 추가', style: AppTextStyle.body3_r(color: AppColor.white)),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColor.primary5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        side: BorderSide(
                          color: AppColor.primary,
                          width: 1.0,
                        ),
                      ),
                      onPressed: (){
                        Get.to(() => JournalBookmarkPage());
                      },
                      child: Text('북마크', style: AppTextStyle.body3_r()),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Obx(
                        () => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.journalPlantList.length + 1,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10, top: 12, bottom: 12),
                              child: GestureDetector(
                                onTap: () {
                                  controller.selectedIdx(index);
                                  if (controller.selectedIdx == 0) {
                                    controller.readJournal();
                                  } else {
                                    controller.filterJournalsByPlant(controller.journalPlantList[controller.selectedIdx.value-1].plantId!);
                                  }
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: controller.selectedIdx.value == index ? AppColor.primary : AppColor.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Text(
                                        index == 0 ? '전체' : '${controller.journalPlantList[index-1].name}',
                                        style: AppTextStyle.body4_r(color: controller.selectedIdx.value == index ? AppColor.white : AppColor.black)
                                      )
                                    )
                                ),
                              ),
                            );
                          }
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.selectedIdx == 0 ? controller.journalList.length : controller.filteredJournalList.length,
                itemBuilder: (context, index) {
                  var journals = controller.selectedIdx == 0 ? controller.journalList : controller.filteredJournalList;
                  final journal = journals[index];
                  final currentJournalDate = journal.writeTime.toDate();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0 ||
                          currentJournalDate.year != journals[index - 1].writeTime.toDate().year ||
                          currentJournalDate.month != journals[index - 1].writeTime.toDate().month ||
                          currentJournalDate.day != journals[index - 1].writeTime.toDate().day)
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
