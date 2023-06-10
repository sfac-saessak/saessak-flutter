
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/view/widget/app_text_field.dart';

import '../../../../controller/schedule_journal/journal_controller.dart';
import '../../../../model/journal.dart';
import '../../../../util/app_color.dart';
import '../../../widget/custom_dropdown_button.dart';

class AddJournalPage extends GetView<JournalController> {
  const AddJournalPage({Key? key, this.journal}) : super(key: key);

  final Journal? journal;

  @override
  Widget build(BuildContext context) {
    if (journal != null) {
      controller.contentController.text = journal!.content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(journal == null ? '일지 추가' : '일지 수정'),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
        actions: [
          journal == null
            ? TextButton(
              onPressed: () {
                controller.addJournal();
                Get.back();
                Get.snackbar('일지', '등록 완');
              },
              child: Text('등록'),
            )
            : TextButton(
              onPressed: () {
                controller.editJournal(journal!);
                Get.snackbar('일지', '수정 완');
              },
              child: Text('수정'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              journal == null
              ? CustomDropDownButton(
                value: controller.selectedPlant.value.name,
                items: controller.plantList.map((plant) => plant.name).toList(),
                onChanged: (String? value) {
                  controller.selectedPlant.value = controller.plantList.firstWhere(
                    (plant) => plant.name == value,
                  );
                  log('${controller.selectedPlant}');
                },
              )
              : Text('${journal!.plant.name}'),
              SizedBox(height: 12),
              AppTextField(hintText: '내용 입력', controller: controller.contentController),
              GestureDetector(
                onTap: controller.selectImage,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: AppColor.black10,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: controller.selectedImage.value != null
                    ? Image.file(controller.selectedImage.value!, fit: BoxFit.cover)
                    : journal == null
                      ? Icon(Icons.add, color: AppColor.black60, size: 30)
                      : journal!.imageUrl != null
                        ? Image.network(journal!.imageUrl!, fit: BoxFit.cover)
                        : Icon(Icons.add, color: AppColor.black60, size: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

