
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('setting'),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
          child: Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.red
              ),
              onPressed: Get.find<AuthController>().logout,
              child: Text('로그아웃'),
            ),
          ),
        ),
      ],
    );
  }
}
