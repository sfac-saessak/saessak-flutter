
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../model/challenge.dart';
import '../../../service/db_service.dart';
import '../../../util/app_color.dart';
import '../../../util/app_routes.dart';
import '../../../util/app_text_style.dart';

class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage({Key? key, required this.challenge}) : super(key: key);
  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('정보', style: AppTextStyle.body2_r()),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("챌린지 포기"),
                    content:
                    Text('${challenge.title} 챌린지를 포기하시겠습니까?'),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          DBService(uid: FirebaseAuth.instance.currentUser!.uid).exitChallenge(challenge.challengeId!);
                          Get.back();
                          Get.snackbar('${challenge.title}', '탈주 완');
                        },
                        icon: const Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  );
                });
              },
              icon: const Icon(Icons.exit_to_app)
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${challenge.title}'),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: Text('${challenge.plant}'),
              ),
              Icon(Icons.access_time, size: 16),
              SizedBox(width: 4),
              Text(
                '${DateFormat("yyyy-MM-dd").format(challenge.startDate.toDate())} ~ ${DateFormat("yyyy-MM-dd").format(challenge.endDate.toDate())}'
              ),
            ],
          ),
          Text('개설자 : ${challenge.admin}')
        ],
      ),
    );
  }
}

