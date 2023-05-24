
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/controller/auth_controller.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  static const String route = '/main';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: [
          Text('main'),
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
      )),
    );
  }
}
