
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/view/widget/app_text_field.dart';

import '../../../../controller/schedule_journal/journal_controller.dart';
import '../../../../model/plant.dart';
import '../../../../util/app_color.dart';
import '../../../widget/custom_dropdown_button.dart';

class AddJournalPage extends GetView<JournalController> {
  const AddJournalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('일지 추가'),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: (){
              controller.addJournal();
              Get.back();
              Get.snackbar('일지', '등록 완');
            },
            child: Text('완료')
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomDropDownButton(
                value: controller.selectedPlant.value.name,
                items: controller.plantList.map((plant) => plant.name).toList(),
                onChanged: (String? value) {
                  controller.selectedPlant.value = controller.plantList.firstWhere(
                    (plant) => plant.name == value,
                  );
                  log('${controller.selectedPlant}');
                },
              ),
              SizedBox(height: 12),
              AppTextField(hintText: '내용 입력', controller: controller.contentController),
              GestureDetector(
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
                        : Icon(Icons.add, color: AppColor.black60, size: 30),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

