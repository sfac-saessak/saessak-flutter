
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/set_profile_controller.dart';

class SetProfilePage extends GetView<SetProfileController> {
  const SetProfilePage({Key? key}) : super(key: key);
  static const String route = '/setProfile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('프로필 사진과 이름을 설정해 주세요!'),
                SizedBox(height: 20),
                GestureDetector(
                  child: Stack(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        child: Obx(
                              () => CircleAvatar(
                            radius: 36,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: controller.selectedImage.value != null
                                ? FileImage(controller.selectedImage.value!)
                                : null,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 40,
                          height: 40,
                          child: CircleAvatar(
                            radius: 36,
                            child: Icon(Icons.edit, color: Colors.white),
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: controller.addProfilePhoto,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    labelText: '이름',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 0
                    ),
                    onPressed: controller.onTapStartBtn,
                    child: Text('설정하기'),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
