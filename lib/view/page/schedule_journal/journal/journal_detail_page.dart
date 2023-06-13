
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saessak_flutter/view/page/schedule_journal/journal/add_journal_page.dart';

import '../../../../controller/schedule_journal/journal_controller.dart';
import '../../../../model/journal.dart';
import '../../../../util/app_color.dart';
import '../../../../util/app_text_style.dart';

class JournalDetailPage extends StatelessWidget {
  const JournalDetailPage({Key? key, required this.journal}) : super(key: key);
  final Journal journal;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<JournalController>();
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text("일지", style: AppTextStyle.body2_m()),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
        actions: journal.uid == controller.user.uid
          ? [
            IconButton(
              onPressed: () {
                Get.off(() => AddJournalPage(journal: journal));
              },
              icon: Icon(Icons.edit)
            ),
            IconButton(
              onPressed: () {
                controller.deleteJournal(journal.journalId!);
              },
              icon: Icon(Icons.delete)
            ),
          ]: null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                    backgroundColor: AppColor.black20,
                    backgroundImage: journal.plant.imageUrl != null ? NetworkImage(journal.plant.imageUrl!) : null,
                    child: journal.plant.imageUrl != null ? null : Icon(Icons.person, color: AppColor.white),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text('${journal.plant.name}', style: AppTextStyle.body3_m()),
                        SizedBox(width: 2),
                        Text('${journal.plant.species}', style: AppTextStyle.body4_r(color: AppColor.black40)),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text('${DateFormat("yyyy-MM-dd").format(journal.writeTime.toDate())}', style: AppTextStyle.body4_r(color: AppColor.black40)),
                  ],
                ),
                Spacer(),
                journal.uid == controller.user.uid
                ? Obx(
                  () => IconButton(
                    onPressed: (){
                      journal.bookmark.toggle();
                      controller.toggleBookmark(journal.journalId!);
                    },
                    icon: Icon(journal.bookmark.value ? Icons.bookmark : Icons.bookmark_outline, color: AppColor.primary)
                  ),
                )
                : Container()
              ],
            ),
            SizedBox(height: 10),
            Text('${journal.content}'),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                image: journal.imageUrl != null ? DecorationImage(image: NetworkImage(journal.imageUrl!)) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
