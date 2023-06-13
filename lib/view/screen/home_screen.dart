
import 'package:flutter/material.dart';
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColor.black40,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.only(right: 20),
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () => Get.to(() => AddPlantPage(plant: null)),
                      icon: Icon(Icons.add),
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
                                Get.to(() => PlantDetailPage(plant: plant), arguments: [plant]);
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    color: AppColor.black20,
                                    borderRadius: BorderRadius.circular(15),
                                    image: plant.imageUrl != null
                                        ? DecorationImage(
                                      image: NetworkImage(plant.imageUrl!),
                                      fit: BoxFit.fitWidth,
                                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
                                    )
                                        : null,
                                  ),
                                  child: Center(child: Text('${controller.reversedPlantList[index].name}', style: AppTextStyle.body3_r(color: AppColor.white)))
                              ),
                            ),
                          );
                        }
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 12),
            Expanded(
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
            )
          ],
        ),
      ),
    );
  }
}
