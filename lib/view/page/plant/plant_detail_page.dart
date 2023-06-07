
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/plant/plant_controller.dart';
import '../../../model/plant.dart';
import '../../../util/app_color.dart';

class PlantDetailPage extends StatelessWidget {
  const PlantDetailPage({Key? key, required this.plant}) : super(key: key);
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlantController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('${plant.name}'),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              controller.deletePlant(plant.plantId!);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
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
              Column(
                children: [
                  Text('${plant.name}'),
                  Text('${plant.species}'),
                  Row(
                    children: [
                      Text('${DateFormat("yyyy-MM-dd").format(plant.plantingDate.toDate())}'),
                      Text(
                        '(D+${controller.getDaysSincePlanting(plant.plantingDate)})'
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Text('급수 주기:'),
              Text('${plant.wateringCycle}'),
            ],
          ),
          Row(
            children: [
              Text('최적 온도:'),
              Text('${plant.optimalTemperature}'),
            ],
          ),
          Row(
            children: [
              Text('빛 요구도:'),
              Text('${plant.lightRequirement}'),
            ],
          ),
          Row(
            children: [
              Text('메모:'),
              Text('${plant.memo}'),
            ],
          ),
        ],
      ),
    );
  }
}

