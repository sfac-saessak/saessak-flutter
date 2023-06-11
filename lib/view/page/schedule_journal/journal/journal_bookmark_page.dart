
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
            return JournalTile(journal: controller.bookmarkList[index]);
          }
        ),
      ),
    );
  }
}

