
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/challenge/challenge_controller.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';
import '../../widget/app_text_field.dart';
import '../../widget/challenge_tile.dart';

class SearchChallengePage extends GetView<ChallengeController> {
  const SearchChallengePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black10,
      appBar: AppBar(
        title: Text('챌린지 검색', style: AppTextStyle.body2_m()),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 12, right: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: AppColor.primary,
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  SizedBox(width: 8.w),
                  Expanded(
                    child: AppTextField(
                      hintText: '검색', 
                      controller: controller.searchController, 
                      onSubmitted: (String value) { controller.searchChallenge(); }
                    )
                  ),
                  IconButton(
                    icon: Icon(Icons.search, color: AppColor.primary),
                    onPressed: controller.searchChallenge,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: controller.searchResultList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: ChallengeTile(challenge: controller.searchResultList[index]),
                    );
                  }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

