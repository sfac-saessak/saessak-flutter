import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/challenge/challenge_controller.dart';
import '../../../model/challenge.dart';
import '../../../model/user_model.dart';
import '../../../service/db_service.dart';
import '../../../util/app_color.dart';
import '../../../util/app_routes.dart';
import '../../../util/app_text_style.dart';

class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage(
      {Key? key, required this.challenge, required this.members})
      : super(key: key);
  final Challenge challenge;
  final List<UserModel> members;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('챌린지 정보', style: AppTextStyle.body2_r()),
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
                        content: Text('${challenge.title} 챌린지를 포기하시겠습니까?'),
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
                              Get.find<ChallengeController>()
                                  .exitChallenge(challenge.challengeId!);
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
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${challenge.plant}',
                style: AppTextStyle.body4_r(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              '${challenge.title}',
              style: AppTextStyle.body1_b(color: AppColor.black80),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Icon(Icons.access_time, size: 16),
                SizedBox(width: 4),
                Text(
                    '챌린지 기간 : ${DateFormat("yyyy-MM-dd").format(challenge.startDate.toDate())} ~ ${DateFormat("yyyy-MM-dd").format(challenge.endDate.toDate())}',
                    style: AppTextStyle.body4_r(color: AppColor.black40)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(challenge.content),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text(
                    '참가자 ',
                    style: AppTextStyle.body2_b(color: AppColor.black80),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.only(left: 2),
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Center(
                      child: Text(
                        '${challenge.members!.length}',
                        style: AppTextStyle.body4_r(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    UserModel member = members[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        leading: CircleAvatar(
                          radius: 24,
                          backgroundColor: AppColor.black50,
                          backgroundImage: member.profileImg != null
                              ? NetworkImage(member.profileImg!)
                              : null,
                          child: member.profileImg != null
                              ? null
                              : Icon(Icons.person, color: AppColor.white),
                        ),
                        title: Row(
                          children: [
                            Text(
                              '${member.name}',
                              style: AppTextStyle.body2_m(),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            challenge.admin.uid == member.uid
                                ? CircleAvatar(
                                    radius: 8,
                                    backgroundColor: AppColor.primary,
                                    child: Image.asset(
                                      'assets/images/crown.png',
                                      width: 12,
                                    ),
                                  )
                                : SizedBox.shrink()
                          ],
                        ),
                        subtitle: Text(
                          '${member.email}',
                          style: AppTextStyle.body3_r(color: AppColor.black60),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
