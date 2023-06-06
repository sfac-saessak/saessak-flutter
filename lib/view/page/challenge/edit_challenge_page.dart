
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/challenge/challenge_controller.dart';
import '../../../model/challenge.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';
import '../../widget/app_text_field.dart';

class EditChallengePage extends GetView<ChallengeController> {
  const EditChallengePage({Key? key, required this.challenge}) : super(key: key);
  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    controller.titleController.text = challenge.title;
    controller.contentController.text = challenge.content;

    return Scaffold(
      appBar: AppBar(
        title: Text('챌린지 수정'),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              controller.editChallenge(challenge);
            },
            child: Text('수정'),
          )
        ],
      ),
      body: Column(
        children: [
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
              Text('${challenge.memberLimit}'),
              Spacer(),
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
          Row(
            children: [
              Text('이름', style: AppTextStyle.body3_m()),
              SizedBox(width: 24),
              Expanded(child: AppTextField(hintText: '챌린지 이름을 입력해주세요', controller: controller.titleController)),
            ],
          ),
          Row(
            children: [
              Text('내용', style: AppTextStyle.body3_m()),
              SizedBox(width: 24),
              Expanded(child: AppTextField(hintText: '챌린지를 설명해주세요', controller: controller.contentController))
            ],
          ),
          Spacer(),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: GestureDetector(
                onTap: controller.selectImage,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColor.black10,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: controller.selectedImage.value != null
                          ? Image.file(controller.selectedImage.value!, fit: BoxFit.cover)
                          : challenge.imageUrl != null
                            ? Image.network(challenge.imageUrl!, fit: BoxFit.cover)
                            : Icon(Icons.add, color: AppColor.black60, size: 30),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

