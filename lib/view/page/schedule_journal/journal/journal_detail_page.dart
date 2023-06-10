
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saessak_flutter/view/page/schedule_journal/journal/add_journal_page.dart';

import '../../../../controller/schedule_journal/journal_controller.dart';
import '../../../../model/journal.dart';
import '../../../../util/app_color.dart';

class JournalDetailPage extends StatelessWidget {
  const JournalDetailPage({Key? key, required this.journal}) : super(key: key);
  final Journal journal;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<JournalController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('${journal.plant.name}'),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
        actions: journal.uid == controller.user.uid
          ? [
            IconButton(
              onPressed: (){
                Get.off(() => AddJournalPage(journal: journal));
              },
              icon: Icon(Icons.edit)
            ),
            IconButton(
              onPressed: (){},
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
                CircleAvatar(
                  backgroundColor: AppColor.black20,
                  backgroundImage: journal.plant.imageUrl != null ? NetworkImage(journal.plant.imageUrl!) : null,
                  child: journal.plant.imageUrl != null ? null : Icon(Icons.person, color: AppColor.white),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${journal.plant.name}'),
                    Text('${DateFormat("yyyy-MM-dd").format(journal.writeTime.toDate())}'),
                  ],
                ),
              ],
            ),
            Text('${journal.content}'),
            Container(
              width: 100,
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
