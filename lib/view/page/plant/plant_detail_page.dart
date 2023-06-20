
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saessak_flutter/view/page/schedule_journal/journal/journal_detail_page.dart';

import '../../../controller/plant/plant_detail_controller.dart';
import '../../../model/plant.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';
import '../../widget/custom_dialog.dart';
import 'add_plant_page.dart';

class PlantDetailPage extends GetView<PlantDetailController> {
  const PlantDetailPage({Key? key, required this.plant}) : super(key: key);
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    print('플랜트 상세 : ${plant}');
    
    return WillPopScope(
      onWillPop: () {
        controller.onDelete();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          title: Text('상세 정보', style: AppTextStyle.body2_m()),
          centerTitle: true,
          backgroundColor: AppColor.white,
          foregroundColor: AppColor.black,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Get.off(() => AddPlantPage(plant: plant));
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                Get.dialog(
                  CustomDialog(
                    leftButtonText: '취소',
                    rightButtonText: '삭제',
                    leftButtonOnTap: () {
                      Get.back();
                    },
                    rightButtonOnTap: () {
                      controller.deletePlant();
                      Get.back();
                    },
                    child: Container(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('${plant.name}을 삭제하시겠습니까?'),
                          ],
                        )
                    ),
                  )
                );
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 55.w,
                    backgroundColor: AppColor.black20,
                    backgroundImage: plant.imageUrl != null
                      ? NetworkImage(plant.imageUrl!)
                      : null,
                    child: plant.imageUrl != null
                      ? null
                      : Icon(Icons.person, color: AppColor.white),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: 150.w),
                            child: Text('${plant.name}', style: AppTextStyle.body2_m())
                          ),
                          SizedBox(width: 4.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(12.w),
                            ),
                            child: Text('D+${controller.getDaysSincePlanting(plant.plantingDate)}', style: AppTextStyle.body4_r(color: AppColor.white)),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        constraints: BoxConstraints(maxWidth: 150.w),
                        child: Text('${plant.species}', style: AppTextStyle.body3_m(color: AppColor.black40))
                      ),
                      Row(
                        children: [
                          Text(
                            '${DateFormat("yyyy-MM-dd").format(plant.plantingDate.toDate())}',
                            style: AppTextStyle.body3_m(color: AppColor.black40)
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text('${plant.memo}', style: AppTextStyle.body3_r()),
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppColor.primary5,
                            borderRadius: BorderRadius.circular(10.w),
                          ),
                          child: Text('온도', style: AppTextStyle.body3_m(color: AppColor.primary))
                        ),
                        SizedBox(width: 4.w),
                        Text('${plant.optimalTemperature}', style: AppTextStyle.body4_r(color: AppColor.black80)),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppColor.primary5,
                            borderRadius: BorderRadius.circular(10.w),
                          ),
                          child: Text('급수', style: AppTextStyle.body3_m(color: AppColor.primary))
                        ),
                        SizedBox(width: 4.w),
                        Text('${plant.wateringCycle}일에 한번', style: AppTextStyle.body4_r(color: AppColor.black80)),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColor.primary5,
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    child: Text('장소', style: AppTextStyle.body3_m(color: AppColor.primary))
                  ),
                  SizedBox(width: 4.w),
                  Text('${plant.lightRequirement}', style: AppTextStyle.body4_r(color: AppColor.black80)),
                ],
              ),
              SizedBox(height: 15.h),
              Expanded(
                child: Obx(
                  () => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : controller.galleryJournal.length > 0
                      ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10.h,
                          crossAxisSpacing: 10.w,
                        ),
                        itemCount: controller.galleryJournal.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => JournalDetailPage(journal: controller.galleryJournal[index]));
                            },
                            child: Image.network(controller.galleryJournal[index].imageUrl!, fit: BoxFit.cover),
                          );
                        },
                      )
                      : Center(child: Text('일지에 사진을 등록해서 갤러리를 채워보세요!', style: AppTextStyle.body3_r())),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
