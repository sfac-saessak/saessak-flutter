import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/plant/plant_controller.dart';
import '../../../model/plant.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';
import '../../widget/app_text_field.dart';

class AddPlantPage extends GetView<PlantController> {
  const AddPlantPage({Key? key, this.plant}) : super(key: key);

  final Plant? plant;

  @override
  Widget build(BuildContext context) {
    if (plant != null) {
      controller.nameController.text = plant!.name;
      controller.speciesController.text = plant!.species;
      controller.plantingDate(plant!.plantingDate);
      controller.optimalTemperatureController.text = plant!.optimalTemperature;
      controller.wateringCycleController.text = plant!.wateringCycle.toString();
      controller.lightRequirementController.text = plant!.lightRequirement;
      controller.memoController.text = plant!.memo!;
    } else {
      controller.nameController.clear();
      controller.speciesController.clear();
      controller.wateringCycleController.clear();
      controller.optimalTemperatureController.clear();
      controller.lightRequirementController.clear();
      controller.memoController.clear();
      controller.plantingDate.value = null;
      controller.selectedImage.value = null;
    }

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text(plant == null ? '식물 등록' : '식물 수정'),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
        actions: [
          plant == null
              ? TextButton(
                  onPressed: () {
                    controller.addPlant();
                  },
                  child: Text(
                    '등록',
                    style: AppTextStyle.body3_m(color: AppColor.primary),
                  ),
                )
              : TextButton(
                  onPressed: () {
                    controller.editPlant(plant!);
                    Get.snackbar('식물', '수정 완');
                  },
                  child: Text('수정'),
                )
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Center(
            child: Container(
              width: 300,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: controller.selectImage,
                        child: Stack(
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 24),
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: AppColor.black10,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: controller.selectedImage.value != null
                                    ? Image.file(
                                        controller.selectedImage.value!,
                                        fit: BoxFit.cover)
                                    : plant == null || plant!.imageUrl == null
                                        ? Opacity(
                                            opacity: 0.2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    'assets/images/logo.png'),
                                                Image.asset(
                                                    'assets/images/title.png')
                                              ],
                                            ),
                                          )
                                        : Image.network(plant!.imageUrl!,
                                            fit: BoxFit.cover)),
                            Positioned(
                                right: 8,
                                bottom: 8,
                                child:
                                    Image.asset('assets/images/addImgBtn.png')),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text('이름', style: AppTextStyle.body2_m()),
                          SizedBox(width: 24),
                          Expanded(
                            child: AppTextField(
                              hintText: '이름 혹은 애칭을 입력하세요',
                              controller: controller.nameController,
                              textStyle:
                                  AppTextStyle.body3_r(color: AppColor.black60),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('식물', style: AppTextStyle.body2_m()),
                          SizedBox(width: 24),
                          Expanded(
                            child: AppTextField(
                              hintText: '식물의 종류를 입력하세요',
                              controller: controller.speciesController,
                              textStyle:
                                  AppTextStyle.body3_r(color: AppColor.black60),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('날짜', style: AppTextStyle.body2_m()),
                          SizedBox(width: 24),
                          Expanded(
                            child: GestureDetector(
                              onTap: controller.selectDate,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 16),
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
                                          : '심은 날짜를 입력하세요',
                                      style: AppTextStyle.body3_m(
                                          color:
                                              controller.plantingDate.value !=
                                                      null
                                                  ? AppColor.black60
                                                  : AppColor.black30),
                                    ),
                                    Spacer(),
                                    Icon(Icons.calendar_today,
                                        size: 16, color: AppColor.primary60),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('급수', style: AppTextStyle.body2_m()),
                          SizedBox(width: 24),
                          Expanded(
                              child: AppTextField(
                            hintText: '급수 주기를 입력하세요 (@일, 숫자 입력)',
                            controller: controller.wateringCycleController,
                            keyboardType: TextInputType.number,
                            textStyle:
                                AppTextStyle.body3_m(color: AppColor.black60),
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          Text('온도', style: AppTextStyle.body2_m()),
                          SizedBox(width: 24),
                          Expanded(
                            child: AppTextField(
                              hintText: '온도를 입력하세요 ex) 00°~00°',
                              controller:
                                  controller.optimalTemperatureController,
                              textStyle:
                                  AppTextStyle.body3_m(color: AppColor.black60),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('장소', style: AppTextStyle.body2_m()),
                          SizedBox(width: 24),
                          Expanded(
                              child: AppTextField(
                            hintText: '키우는 장소를 입력하세요',
                            controller: controller.lightRequirementController,
                            textStyle:
                                AppTextStyle.body3_m(color: AppColor.black60),
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          Text('메모', style: AppTextStyle.body2_m()),
                          SizedBox(width: 24),
                          Expanded(
                              child: AppTextField(
                            hintText: '간단한 메모를 입력하세요',
                            controller: controller.memoController,
                            textStyle:
                                AppTextStyle.body3_m(color: AppColor.black60),
                          )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
