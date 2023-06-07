
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/plant/plant_controller.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';
import '../../widget/app_text_field.dart';

class AddPlantPage extends GetView<PlantController> {
  const AddPlantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text('식물 등록'),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: controller.addPlant,
            child: Text('등록'),
          )
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: GestureDetector(
                  onTap: controller.selectImage,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: AppColor.black10,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: controller.selectedImage.value != null
                            ? Image.file(controller.selectedImage.value!, fit: BoxFit.cover)
                            : Icon(Icons.add, color: AppColor.black60, size: 30),
                      ),
                      Row(
                        children: [
                          Text('애칭', style: AppTextStyle.body3_m()),
                          SizedBox(width: 24),
                          Expanded(child: AppTextField(hintText: '애칭', controller: controller.nameController)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('종류', style: AppTextStyle.body3_m()),
                          SizedBox(width: 24),
                          Expanded(child: AppTextField(hintText: '종류', controller: controller.speciesController)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('기간', style: AppTextStyle.body3_m()),
                          SizedBox(width: 24),
                          GestureDetector(
                            onTap: controller.selectDate,
                            child: Container(
                              padding: EdgeInsets.only(left: 2, right: 2, bottom: 3),
                              width: 110,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColor.black20,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    controller.plantingDate.value != null
                                        ? '${DateFormat("yyyy-MM-dd").format(controller.plantingDate.value!.toDate())}'
                                        : '선택',
                                    style: AppTextStyle.body3_m(),
                                  ),
                                  Spacer(),
                                  Icon(Icons.calendar_today, size: 16, color: AppColor.primary60),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('급수주기', style: AppTextStyle.body3_m()),
                          SizedBox(width: 24),
                          Expanded(child: AppTextField(hintText: '00일', controller: controller.wateringCycleController)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('최적온도', style: AppTextStyle.body3_m()),
                          SizedBox(width: 24),
                          Expanded(child: AppTextField(hintText: '00~00°', controller: controller.optimalTemperatureController)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('빛 요구도', style: AppTextStyle.body3_m()),
                          SizedBox(width: 24),
                          Expanded(child: AppTextField(hintText: '00~00°', controller: controller.lightRequirementController)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('메모', style: AppTextStyle.body3_m()),
                          SizedBox(width: 24),
                          Expanded(child: AppTextField(hintText: '간단한 메모', controller: controller.memoController)),
                        ],
                      ),
                    ],
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

