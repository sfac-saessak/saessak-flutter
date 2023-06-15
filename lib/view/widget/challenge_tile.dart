import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/challenge/challenge_controller.dart';
import '../../model/challenge.dart';
import '../../util/app_color.dart';
import '../../util/app_text_style.dart';
import '../page/challenge/challenge_detail_page.dart';

class ChallengeTile extends StatelessWidget {
  const ChallengeTile({Key? key, required this.challenge}) : super(key: key);
  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ChallengeController>();
    bool challengeEnd = controller.getDeadline(challenge.startDate) > 0;
    print(challenge.memberLimit == null);
    return GestureDetector(
      onTap: () {
        Get.to(() => ChallengeDetailPage(
            challenge: challenge, challengeEnd: challengeEnd));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: challengeEnd ? AppColor.black20 : AppColor.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 200),
                  child: Text('${challenge.title}', style: AppTextStyle.body3_b(), overflow: TextOverflow.ellipsis)
                ),
                SizedBox(width: 10),
                Icon(Icons.people, color: AppColor.primary, size: 16),
                SizedBox(width: 4),
                Text(
                    '${challenge.members!.length} / ${challenge.memberLimit != null ? challenge.memberLimit : '제한없음'}',
                    style: AppTextStyle.body4_r()),
                Spacer(),
                challengeEnd
                    ? Text('종료', style: AppTextStyle.body5_m(color: Colors.red))
                    : Text(
                        controller.getDeadline(challenge.startDate) == 0
                            ? '챌린지 D-DAY'
                            : '시작까지 D${controller.getDeadline(challenge.startDate)}',
                        style: AppTextStyle.body5_m())
              ],
            ),
            SizedBox(height: 8),
            Container(
                width: 250,
                child: Text('${challenge.content}',
                    style: AppTextStyle.body4_r(color: AppColor.black70),
                    overflow: TextOverflow.ellipsis)),
            SizedBox(height: 14),
            Row(
              children: [
                Icon(Icons.access_time, color: AppColor.black40, size: 16),
                SizedBox(width: 4),
                Text(
                    '챌린지 기간 : ${DateFormat("yyyy-MM-dd").format(challenge.startDate.toDate())} ~ ${DateFormat("yyyy-MM-dd").format(challenge.endDate.toDate())}',
                    style: AppTextStyle.body5_r(color: AppColor.black40)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
