
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../page/schedule_journal/journal/add_journal_page.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: (){
            Get.to(() => AddJournalPage());
          },
          child: Text('일지 등록'),
        )
      ],
    );
  }
}
