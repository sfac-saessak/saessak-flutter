import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saessak_flutter/component/login/custom_button.dart';
import '../../../controller/challenge/challenge_controller.dart';
import '../../../model/challenge.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';
import 'edit_challenge_page.dart';

class ChallengeDetailPage extends GetView<ChallengeController> {
  const ChallengeDetailPage(
      {Key? key, required this.challenge, required this.challengeEnd})
      : super(key: key);
  final Challenge challenge;
  final bool challengeEnd;

  @override
  Widget build(BuildContext context) {
    print(controller.user.uid);
    print(challenge.admin);
    return Scaffold(
      appBar: AppBar(
        title: Text('챌린지'),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
        actions: controller.user.uid == challenge.admin
            ? [
                IconButton(
                  onPressed: () =>
                      Get.off(() => EditChallengePage(challenge: challenge)),
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                ),
              ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,

                  // backgroundImage: controller.user.photoURL != null
                  //     ? NetworkImage(controller.user.photoURL!)
                  //     : null,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  '챌린지 작성자 넣어주세요',
                  style: AppTextStyle.body1_m(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(
                  '${challenge.title}',
                  style: AppTextStyle.body2_b(color: AppColor.black90),
                ),
                SizedBox(
                  width: 4,
                ),
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
                Spacer(),
                Icon(
                  Icons.people,
                  color: AppColor.primary,
                ),
                Text(
                  '  ${challenge.members!.length} / ${challenge.memberLimit != null ? challenge.memberLimit : '제한없음'}',
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: AppColor.black40,
                ),
                SizedBox(width: 4),
                Text(
                  '${DateFormat("yyyy-MM-dd").format(challenge.startDate.toDate())} ~ ${DateFormat("yyyy-MM-dd").format(challenge.endDate.toDate())}',
                  style: AppTextStyle.body4_r(color: AppColor.black40),
                ),
                Spacer(),
                challengeEnd
                    ? Text(
                        '모집 마감',
                        style: AppTextStyle.body4_m(color: AppColor.black40),
                      )
                    : Text(
                        controller.getDeadline(challenge.startDate) == 0
                            ? '마감 D-DAY'
                            : '마감 D${controller.getDeadline(challenge.startDate)}',
                        style: AppTextStyle.body4_r(color: AppColor.primary80))
              ],
            ),
            SizedBox(
              height: 32,
            ),
            challenge.imageUrl != null
                ? Container(
                    width: double.infinity,
                    height: 150,
                    color: Colors.grey[300],
                    child:
                        Image.network(challenge.imageUrl!, fit: BoxFit.cover))
                : Container(),
            SizedBox(
              height: 16,
            ),
            Text(
              '${challenge.content}',
              style: AppTextStyle.body2_r(color: AppColor.black70),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: CustomButton(
                onPressed: () {
                  challengeEnd
                      ? Get.snackbar('참가 실패', '모집이 끝난 챌린지입니다.')
                      : showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("참가"),
                              content: Text('${challenge.title}에 참가하시겠습니까?'),
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
                                    controller
                                        .joinChallenge(challenge.challengeId!);
                                    Get.snackbar('${challenge.title}', '참가 완');
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
                text: '참가하기',
                textStyle: AppTextStyle.body2_b(color: Colors.white),
                isenableButton: challengeEnd ? false : true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
