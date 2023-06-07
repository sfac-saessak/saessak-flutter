
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/view/page/plant/plant_detail_page.dart';

import '../../model/plant.dart';
import '../../util/app_color.dart';
import '../../util/app_text_style.dart';

class PlantTile extends StatelessWidget {
  const PlantTile({Key? key, required this.plant}) : super(key: key);
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: GestureDetector(
        onTap: () {
          Get.to(() => PlantDetailPage(plant: plant));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: AppColor.white,
          ),
          child: Column(
            children: [
              Container(
                width: 200,
                height: 200,
                child: CircleAvatar(
                  backgroundColor: AppColor.black20,
                  backgroundImage: plant.imageUrl != null ? NetworkImage(plant.imageUrl!) : null,
                  child: plant.imageUrl != null ? null : Icon(Icons.person, color: AppColor.white),
                ),
              ),
              Text('${plant.name}'),
              Text('${plant.species}', style: AppTextStyle.body3_m(color: AppColor.primary)),
            ],
          ),
        ),
      ),
    );
  }
}

