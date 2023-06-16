import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/util/app_text_style.dart';
import 'package:saessak_flutter/view/widget/plant_tile.dart';

import '../../controller/plant/plant_controller.dart';
import '../../util/app_color.dart';
import '../page/plant/add_plant_page.dart';
import '../page/plant/plant_detail_page.dart';
import '../widget/custom_dropdown_button.dart';

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
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  color: AppColor.black40,
                  image: DecorationImage(
                      image: AssetImage(controller.forestBackground),
                      fit: BoxFit.cover)),
            ),
            SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.only(right: 20),
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => AddPlantPage(plant: null));
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColor.primary),
                        ),
                        child: Icon(Icons.add, color: AppColor.primary),
                      ),
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
                                    borderRadius: BorderRadius.circular(15),
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
            SizedBox(height: 12),
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
                    mainAxisSpacing: 16,
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
