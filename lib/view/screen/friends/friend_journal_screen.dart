
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/follow/friend_detail_controller.dart';
import '../../../util/app_color.dart';
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
              return JournalTile(journal: controller.journalList[index]);
            },
          ),
        ),
      ),
    );
  }
}
