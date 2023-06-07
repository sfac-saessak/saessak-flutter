
import 'package:flutter/material.dart';

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
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: AppColor.white,
        ),
        child: Column(
          children: [
            plant.imageUrl != null
              ? Container(
                width: double.infinity,
                height: 150,
                color: Colors.grey[300],
                child: Image.network(plant.imageUrl!, fit: BoxFit.cover)
              )
              : Container(),
            Text('${plant.name}'),
            Text('${plant.species}', style: AppTextStyle.body3_m(color: AppColor.primary)),
          ],
        ),
      ),
    );
  }
}

