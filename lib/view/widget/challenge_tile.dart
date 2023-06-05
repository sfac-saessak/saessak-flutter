
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/challenge.dart';
import '../../util/app_color.dart';
import '../../util/app_text_style.dart';
import '../page/challenge/challenge_detail_page.dart';

class ChallengeTile extends StatelessWidget {
  const ChallengeTile({Key? key, required this.challenge}) : super(key: key);
  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ChallengeDetailPage(challenge: challenge));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('${challenge.title}', style: AppTextStyle.body3_b()),
                SizedBox(width: 10),
                Icon(Icons.people, color: AppColor.primary, size: 16),
                SizedBox(width: 4),
                Text('${challenge.memberLimit}', style: AppTextStyle.body4_r()),
                Spacer(),
                Text('마감 1일 전', style: AppTextStyle.body5_m()),
              ],
            ),
            SizedBox(height: 8),
            Container(
              width: 250,
              child: Text('${challenge.content}', style: AppTextStyle.body4_r(color: AppColor.darkGrey), overflow: TextOverflow.ellipsis)
            ),
            SizedBox(height: 14),
            Row(
              children: [
                Icon(Icons.access_time, color: AppColor.grey, size: 16),
                SizedBox(width: 4),
                Text(
                  '${DateFormat("yyyy-MM-dd").format(challenge.startDate.toDate())} ~ ${DateFormat("yyyy-MM-dd").format(challenge.endDate.toDate())}',
                  style: AppTextStyle.body5_r(color: AppColor.grey)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

