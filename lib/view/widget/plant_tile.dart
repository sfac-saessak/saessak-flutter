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
    return GestureDetector(
      onTap: () {
        Get.to(() => PlantDetailPage(plant: plant), arguments: [plant]);
      },
      child: Column(
        children: [
          plant.imageUrl != null
              ? Image.network(
                  plant.imageUrl!,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 70,
                        backgroundImage: NetworkImage(plant.imageUrl!),
                      );
                    }
                    return CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 70,
                      child: CircularProgressIndicator(
                        color: AppColor.primary,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                )
              : CircleAvatar(
                  radius: 70,
                  backgroundColor: AppColor.black10,
                  child: Opacity(
                      opacity: 0.2,
                      child: Image.asset('assets/images/logo.png')),
                ),
          Text('${plant.name}'),
          Text('${plant.species}',
              style: AppTextStyle.body3_m(color: AppColor.primary)),
        ],
      ),
    );
  }
}
