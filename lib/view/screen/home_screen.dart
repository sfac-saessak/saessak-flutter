import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/util/app_text_style.dart';
import 'package:saessak_flutter/view/widget/plant_tile.dart';

import '../../controller/plant/plant_controller.dart';
import '../../util/app_color.dart';
import '../page/plant/add_plant_page.dart';
import '../page/plant/plant_detail_page.dart';

class HomeScreen extends GetView<PlantController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: AppColor.white,
        child: Column(
          children: [
            Container(
              width: double.infinity.w,
              height: 210.h,
              decoration: BoxDecoration(
                  color: AppColor.black40,
                  image: DecorationImage(
                      image: AssetImage(controller.forestBackground),
                      fit: BoxFit.cover)),
            ),
            Container(
              color: AppColor.black10,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
              height: 56.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => AddPlantPage(plant: null));
                    },
                    child: Container(
                      width: 36.h,
                      height: 36.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColor.primary),
                      ),
                      child: Icon(Icons.add, color: AppColor.primary),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.reversedPlantList.length,
                        itemBuilder: (context, index) {
                          var plant = controller.reversedPlantList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => PlantDetailPage(plant: plant),
                                    arguments: [plant]);
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    color: AppColor.black20,
                                    borderRadius: BorderRadius.circular(20.r),
                                    image: plant.imageUrl != null
                                        ? DecorationImage(
                                            image:
                                                NetworkImage(plant.imageUrl!),
                                            fit: BoxFit.fitWidth,
                                            colorFilter: ColorFilter.mode(
                                                Colors.black.withOpacity(0.2),
                                                BlendMode.darken),
                                          )
                                        : null,
                                  ),
                                  child: Center(
                                      child: Text(
                                          '${controller.reversedPlantList[index].name}',
                                          style: AppTextStyle.body3_r(
                                              color: AppColor.white)))),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: controller.plantList.length,
                  itemBuilder: (context, index) {
                    return PlantTile(plant: controller.plantList[index]);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.h,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
