import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/component/login/custom_button.dart';
import 'package:saessak_flutter/component/login/custom_text_field.dart';
import 'package:saessak_flutter/util/app_color.dart';

import '../../controller/set_profile_controller.dart';

class SetProfilePage extends GetView<SetProfileController> {
  const SetProfilePage({Key? key}) : super(key: key);
  static const String route = '/setProfile';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  GestureDetector(
                    child: Stack(
                      children: [
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: Get.width * 0.48,
                              height: Get.width * 0.5,
                              decoration: BoxDecoration(
                                  color: AppColor.lightGrey,
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: controller.selectedImage.value ==
                                              null
                                          ? AssetImage('assets/images/logo.png')
                                          : AssetImage(controller
                                              .selectedImage.value!.path),
                                      opacity:
                                          controller.selectedImage.value == null
                                              ? 0.2
                                              : 1.0,
                                      fit:
                                          controller.selectedImage.value == null
                                              ? null
                                              : BoxFit.cover)),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 48,
                            height: 48,
                            child: CircleAvatar(
                              radius: 36,
                              child: Icon(Icons.edit, color: Colors.white),
                              backgroundColor:
                                  controller.selectedImage.value == null
                                      ? AppColor.lightGrey
                                      : AppColor.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: controller.addProfilePhoto,
                  ),
                  SizedBox(height: 58),
                  CustomTextField(
                    controller: controller.nameController,
                    hintText: '이름을 입력해주세요.',
                    onChanged: controller.onChanged,
                  ),
                  SizedBox(height: 16),
                  Obx(() => CustomButton(
                      onPressed: controller.onTapStartBtn,
                      text: '설정하기',
                      isenableButton: controller.isEnableButton.value)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
