
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/challenge/challenge_controller.dart';
import '../../widget/app_text_field.dart';

class AddChallengePage extends GetView<ChallengeController> {
  const AddChallengePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('새 챌린지'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: controller.createChallenge,
            child: Text('등록'),
          ),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            Row(
              children: [
                Text('식물'),
                Expanded(child: AppTextField(hintText: '입력', controller: controller.plantController)),
              ],
            ),
            Row(
              children: [
                Text('인원수'),
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
            Row(
              children: [
                Text('기간'),
                ElevatedButton(
                  onPressed: () {
                    controller.selectDate(true);
                  },
                  child: Text(
                    controller.startDate.value != null
                        ? '${DateFormat("yyyy-MM-dd").format(controller.startDate.value!)}'
                        : '날짜 선택',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Text(' ~ '),
                ElevatedButton(
                  onPressed: () {
                    controller.selectDate(false);
                  },
                  child: Text(
                    controller.endDate.value != null
                        ? '${DateFormat("yyyy-MM-dd").format(controller.endDate.value!)}'
                        : '날짜 선택',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            AppTextField(hintText: '제목 입력', controller: controller.titleController),
            AppTextField(hintText: '내용 입력', controller: controller.contentController),
            GestureDetector(
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
          ],
        ),
      ),
    );
  }
}
