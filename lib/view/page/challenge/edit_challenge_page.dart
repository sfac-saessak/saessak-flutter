
import 'package:flutter/material.dart';

import '../../../util/app_color.dart';

class EditChallengePage extends StatelessWidget {
  const EditChallengePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('챌린지 수정'),
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
      ),
    );
  }
}

