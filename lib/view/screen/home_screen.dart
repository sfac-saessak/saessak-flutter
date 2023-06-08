
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/view/widget/plant_tile.dart';

import '../../controller/plant/plant_controller.dart';
import '../../util/app_color.dart';
import '../page/plant/add_plant_page.dart';

class HomeScreen extends GetView<PlantController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.black10,
      child: Column(
        children: [
          IconButton(
            onPressed: () => Get.to(() => AddPlantPage(plant: null)),
            icon: Icon(Icons.add),
          ),
          Expanded(
            child: Obx(
              () => controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : PageView.builder(
                  controller: controller.pageController,
                  itemCount: controller.plantList.length,
                  itemBuilder: (context, index) {
                    return PlantTile(plant: controller.plantList[index]);
                  }
                ),
            )
          )
        ],
      ),
    );
  }
}
