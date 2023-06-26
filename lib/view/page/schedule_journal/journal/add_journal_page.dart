import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/view/widget/app_text_field.dart';

import '../../../../controller/schedule_journal/journal_controller.dart';
import '../../../../model/journal.dart';
import '../../../../util/app_color.dart';
import '../../../../util/app_text_style.dart';
import '../../../widget/custom_dropdown_button.dart';

class AddJournalPage extends GetView<JournalController> {
  const AddJournalPage({Key? key, this.journal}) : super(key: key);

  final Journal? journal;

  @override
  Widget build(BuildContext context) {
    if (journal != null) {
      controller.contentController.text = journal!.content;
    } else {
      controller.contentController.text = '';
      controller.selectedImage.value = null;
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
                    Get.snackbar('등록 완료', '일지를 기록했습니다.');
                  },
                  child: Text(
                    '등록',
                    style: AppTextStyle.body3_m(color: AppColor.primary),
                  ),
                )
              : TextButton(
                  onPressed: () {
                    controller.editJournal(journal!);
                    Get.snackbar('수정 완료', '일지를 수정했습니다.');
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
              Row(
                children: [
                  Text('식물', style: AppTextStyle.body2_m()),
                  SizedBox(width: 24),
                  journal == null
                      ? Expanded(
                          child: DropdownButton(
                            value: controller.selectedPlant.value.plantId,
                            items: controller.plantList
                              .map((plant) => DropdownMenuItem(
                                  value: plant.plantId,
                                  child: Text('${plant.name}')
                              ))
                              .toList(),
                            onChanged: (value) {
                              controller.selectedPlant.value =
                                  controller.plantList.firstWhere(
                                (plant) => plant.plantId == value,
                              );
                              log('${controller.selectedPlant}');
                            },
                          ),
                        )
                      : Text('${journal!.plant.name}'),
                ],
              ),
              Expanded(
                child: Container(
                  width: Get.width,
                  margin: EdgeInsets.only(top: 12),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: AppColor.black20,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  child: TextFormField(
                    controller: controller.contentController,
                    // keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: '내용 입력', border: InputBorder.none),
                    style: AppTextStyle.body3_r(color: AppColor.black90),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  '사진첨부',
                  style: AppTextStyle.body3_b(color: AppColor.black90),
                ),
              ),
              GestureDetector(
                onTap: controller.selectImage,
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: AppColor.black10,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: controller.selectedImage.value != null
                      ? Image.file(controller.selectedImage.value!,
                          fit: BoxFit.cover)
                      : journal == null
                          ? Icon(Icons.add, color: AppColor.black60, size: 30)
                          : journal!.imageUrl != null
                              ? Image.network(journal!.imageUrl!,
                                  fit: BoxFit.cover)
                              : Icon(Icons.add,
                                  color: AppColor.black60, size: 30),
                ),
              ),
              SizedBox(
                height: Get.height / 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
