
import 'package:flutter/material.dart';

import '../../../util/app_color.dart';

class AddPlantPage extends StatelessWidget {
  const AddPlantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text('식물 등록'),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: (){},
            child: Text('등록'),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: GestureDetector(
              onTap: (){},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: AppColor.black10,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    // child: controller.selectedImage.value != null
                    //     ? Image.file(controller.selectedImage.value!, fit: BoxFit.cover)
                    //     : Icon(Icons.add, color: AppColor.black60, size: 30),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

