import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../util/app_color.dart';
import '../../util/app_routes.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              width: 150,
              height: 150,
              child: CircleAvatar(
                backgroundColor: AppColor.black20,
                backgroundImage: FirebaseAuth.instance.currentUser!.photoURL !=
                        null
                    ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
                    : null,
                child: FirebaseAuth.instance.currentUser!.photoURL != null
                    ? null
                    : Icon(Icons.person, color: AppColor.white),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${FirebaseAuth.instance.currentUser!.displayName}'),
                Text(
                  '${FirebaseAuth.instance.currentUser!.email}',
                  style: TextStyle(color: AppColor.black50),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.setName);
              },
              icon: Icon(Icons.edit),
            ),
          ],
        ),
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
                  backgroundColor: Colors.red),
              onPressed: Get.find<AuthController>().logout,
              child: Text('로그아웃'),
            ),
          ),
        ),
      ],
    );
  }
}
