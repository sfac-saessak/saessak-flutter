
import 'package:flutter/material.dart';

import '../../../../util/app_color.dart';

class AddJournalPage extends StatelessWidget {
  const AddJournalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('일지 추가'),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
        actions: [
          TextButton(onPressed: (){}, child: Text('완료'))
        ],
      ),
    );
  }
}

