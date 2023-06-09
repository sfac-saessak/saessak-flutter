
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/challenge/challenge_controller.dart';
import '../../model/challenge.dart';
import '../../util/app_color.dart';
import '../../util/app_routes.dart';
import '../../util/app_text_style.dart';
import '../page/challenge/challenge_detail_page.dart';
import '../page/challenge/chat_page.dart';

class JoinedChallengeTile extends StatelessWidget {
  const JoinedChallengeTile({Key? key, required this.challenge}) : super(key: key);
  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.chat, arguments: [challenge]);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: challenge.progressStatus! ? AppColor.white : AppColor.black20,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 250),
                  child: Text('${challenge.title}', style: AppTextStyle.body3_b(), overflow: TextOverflow.ellipsis)),
                SizedBox(width: 10),
                Icon(Icons.people, color: AppColor.primary, size: 16),
                SizedBox(width: 4),
                Text('${challenge.members!.length}', style: AppTextStyle.body4_r()),
                Spacer(),
                challenge.progressStatus!
                  ? Text('진행', style: AppTextStyle.body5_m(color: AppColor.primary))
                  : Text('종료', style: AppTextStyle.body5_m(color: Colors.red)),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 250,
                  child: Text(
                    challenge.recentMessageSender != ''
                      ? '${challenge.recentMessageSender}: ${challenge.recentMessage}'
                      : '채팅을 시작해 보세요!',
                    style: AppTextStyle.body4_r(color: AppColor.black70),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2
                  ),
                ),
                Spacer(),
                Text(
                  challenge.recentMessageTime != null
                    ? '${Get.find<ChallengeController>().convertTime(challenge.recentMessageTime!)}'
                    : '',
                  style: AppTextStyle.body5_r(color: AppColor.black30)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
