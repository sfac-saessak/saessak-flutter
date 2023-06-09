
import 'package:flutter/material.dart';

import '../../../util/app_color.dart';

class FriendJournalScreen extends StatelessWidget {
  const FriendJournalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primary5,
      child: Center(
        child: Text('일지'),
      ),
    );
  }
}
