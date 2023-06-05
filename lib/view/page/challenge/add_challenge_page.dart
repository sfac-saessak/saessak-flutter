
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/challenge/challenge_controller.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';
import '../../widget/app_text_field.dart';

class AddChallengePage extends GetView<ChallengeController> {
  const AddChallengePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text('새 챌린지', style: AppTextStyle.body2_m()),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              controller.createChallenge();
              Get.back();
              Get.snackbar('챌린지', '등록 완');
            },
            child: Text('완료', style: AppTextStyle.body3_m(color: AppColor.primary)),
          ),
        ],
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('이름', style: AppTextStyle.body2_b()),
                  SizedBox(width: 18),
                  Expanded(child: AppTextField(hintText: '챌린지 이름을 입력해주세요', controller: controller.titleController)),
                ],
              ),
              Row(
                children: [
                  Text('식물', style: AppTextStyle.body2_b()),
                  SizedBox(width: 18),
                  Expanded(child: AppTextField(hintText: '함께 키울 식물을 입력해주세요', controller: controller.plantController)),
                ],
              ),
              Row(
                children: [
                  Text('기간', style: AppTextStyle.body2_b()),
                  SizedBox(width: 18),
                  GestureDetector(
                    onTap: () {
                      controller.selectDate(true);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 2, right: 2, bottom: 3),
                      width: 110,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColor.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            controller.startDate.value != null
                              ? '${DateFormat("yyyy-MM-dd").format(controller.startDate.value!.toDate())}'
                              : '선택',
                            style: AppTextStyle.body3_m(),
                          ),
                          Spacer(),
                          Icon(Icons.calendar_today, size: 16, color: AppColor.grey),
                        ],
                      ),
                    ),
                  ),
                  Text(' ~ '),
                  GestureDetector(
                    onTap: () {
                      controller.selectDate(false);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 2, right: 2, bottom: 3),
                      width: 110,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColor.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            controller.endDate.value != null
                              ? '${DateFormat("yyyy-MM-dd").format(controller.endDate.value!.toDate())}'
                              : '선택',
                            style: AppTextStyle.body3_m(),
                          ),
                          Spacer(),
                          Icon(Icons.calendar_today, size: 16, color: AppColor.grey),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('인원', style: AppTextStyle.body2_b()),
                  SizedBox(width: 18),
                  DropdownButton(
                    value: controller.selectedMemberLimit.value,
                    items: controller.memberLimitList.map((String value) {
                      return DropdownMenuItem(
                        value: value == '전체' ? null : int.parse(value),
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (int? value) {
                      log('value=> $value');
                      if (value == null) print('전체');
                      controller.setSelectedMemberLimit(value);
                    },
                    hint: Text('${controller.selectedMemberLimit.value ?? '전체'}'),
                  ),
                ],
              ),
              Expanded(child: AppTextField(hintText: '챌린지를 설명해주세요', controller: controller.contentController)),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: GestureDetector(
                  onTap: controller.selectImage,
                  child: Container(
                    width: 150,
                    height: 150,
                    color: Colors.grey[300],
                    child: controller.selectedImage.value != null
                      ? Image.file(controller.selectedImage.value!, fit: BoxFit.cover)
                      : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
