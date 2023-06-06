
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/challenge/challenge_controller.dart';
import '../../../model/challenge.dart';
import '../../../service/db_service.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';
import 'edit_challenge_page.dart';

class ChallengeDetailPage extends StatelessWidget {
  const ChallengeDetailPage({Key? key, required this.challenge, required this.challengeEnd}) : super(key: key);
  final Challenge challenge;
  final bool challengeEnd;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ChallengeController>();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('챌린지'),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
        actions: controller.user.uid == challenge.admin ? [
          IconButton(
            onPressed: () => Get.off(() => EditChallengePage(challenge: challenge)),
            icon: Icon(Icons.edit),
          ),
          // IconButton(
          //   onPressed: (){},
          //   icon: Icon(Icons.delete),
          // ),
        ] : null,
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
                challengeEnd
                  ? Text('모집 마감')
                  : Text(
                  controller.getDeadline(challenge.startDate) == 0
                    ? '마감 D-DAY'
                    : '마감 D${controller.getDeadline(challenge.startDate)}'
                )
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
                width: double.infinity,
                height: 150,
                color: Colors.grey[300],
                child: Image.network(challenge.imageUrl!, fit: BoxFit.cover)
              )
              : Container(),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  challengeEnd
                    ? Get.snackbar('참가 실패', '모집이 끝난 챌린지입니다.')
                    : showDialog(
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
                                  controller.joinChallenge(challenge.challengeId!);
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

