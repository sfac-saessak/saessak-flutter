
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../model/challenge.dart';
import '../../../service/db_service.dart';
import '../../../util/app_color.dart';

class ChallengeDetailPage extends StatelessWidget {
  const ChallengeDetailPage({Key? key, required this.challenge}) : super(key: key);
  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('챌린지'),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${challenge.title}'),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent, // 컨테이너의 배경색
                    borderRadius: BorderRadius.circular(10), // 모서리의 둥근 정도 설정
                    border: Border.all(
                      color: Colors.black, // 테두리의 색상
                      width: 1, // 테두리의 두께
                    ),
                  ),
                  child: Text('${challenge.plant}'),
                ),
                Icon(Icons.people),
                Text('${challenge.memberLimit}'),
                Spacer(),
                Text('3시간 전'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.access_time, size: 16),
                SizedBox(width: 4),
                Text(
                  '${DateFormat("yyyy-MM-dd").format(challenge.startDate.toDate())} ~ ${DateFormat("yyyy-MM-dd").format(challenge.endDate.toDate())}'
                ),
              ],
            ),
            SizedBox(height: 40,),
            Text('${challenge.content}'),
            Spacer(),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("참가"),
                        content:
                        Text('${challenge.title}에 참가하시겠습니까?'),
                        actions: [
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              DBService(uid: FirebaseAuth.instance.currentUser!.uid).joinChallenge(challenge.challengeId!);
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    }
                  );
                },
                child: Text('참가하기'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

