
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/challenge/challenge_controller.dart';
import '../../page/challenge/add_challenge_page.dart';

class AllChallengeScreen extends GetView<ChallengeController> {
  const AllChallengeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Center(
            child: Text('all'),
          ),
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: ElevatedButton(
            onPressed: () => Get.to(() => AddChallengePage()),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: Colors.green,
              elevation: 0,
              padding: EdgeInsets.all(16.0), // 초록색 배경
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 24.0,
            ),
          ),
        ),
      ],
    );
  }
}
