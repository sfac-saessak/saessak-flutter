
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../page/plant/add_plant_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () => Get.to(() => AddPlantPage()),
          icon: Icon(Icons.add),
        )
      ],
    );
  }
}
