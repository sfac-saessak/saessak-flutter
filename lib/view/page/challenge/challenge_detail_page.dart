
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
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: Text('${challenge.plant}'),
                ),
                Icon(Icons.people),
                Text('${challenge.members!.length}/${challenge.memberLimit}'),
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
            challenge.imageUrl != null
              ? Container(
                width: 150,
                height: 150,
                color: Colors.grey[300],
                child: Image.network(challenge.imageUrl!, fit: BoxFit.cover)
              )
              : Container(),
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
                              Get.back();
                              Get.snackbar('${challenge.title}', '참가 완');
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

