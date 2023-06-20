import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/auth_controller.dart';
import '../../controller/setting_controller.dart';
import '../../util/app_color.dart';
import '../../util/app_text_style.dart';
import '../page/friends/friends_list_page.dart';
import '../page/notice_page.dart';
import '../widget/custom_dialog.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.black10,
      child: Obx(
        () => Column(
          children: [
            Container(
              width: Get.width,
              color: AppColor.white,
              child: Column(
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    child: CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.grey,
                      child: controller.user.photoURL == null
                          ? Icon(Icons.person, color: Colors.white)
                          : null,
                      backgroundImage: controller.user.photoURL != null
                          ? NetworkImage(controller.user.photoURL!)
                          : null,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(controller.user.displayName!,
                      style: AppTextStyle.body2_m()),
                  Text(controller.user.email!,
                      style: AppTextStyle.body4_r(color: AppColor.black40)),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => FriendsListPage(
                                  userName: controller.user.displayName!,
                                  followingList: controller.followingList,
                                  followerList: controller.followerList), arguments: [controller.followingList, controller.followerList]);
                            },
                            child: Column(
                              children: [
                                Text('${controller.followerList.length}',
                                    style: AppTextStyle.body1_m()),
                                SizedBox(height: 6),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColor.black10,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text('팔로워',
                                        style: AppTextStyle.body5_r()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => FriendsListPage(
                                  userName: controller.user.displayName!,
                                  followingList: controller.followingList,
                                  followerList: controller.followerList), arguments: [controller.followingList, controller.followerList]);
                            },
                            child: Column(
                              children: [
                                Text('${controller.followingList.length}',
                                    style: AppTextStyle.body1_m()),
                                SizedBox(height: 6),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColor.black10,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text('팔로잉',
                                        style: AppTextStyle.body5_r()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              Text('${controller.journalList.length}',
                                  style: AppTextStyle.body1_m()),
                              SizedBox(height: 6),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColor.black10,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child:
                                      Text('일지', style: AppTextStyle.body5_r()),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              Text('${controller.myPostList.length}',
                                  style: AppTextStyle.body1_m()),
                              SizedBox(height: 6),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColor.black10,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text('게시글',
                                      style: AppTextStyle.body5_r()),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => NoticePage());
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 18),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          border: Border(
                            bottom: BorderSide(
                              color: AppColor.black20,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text('공지사항', style: AppTextStyle.body2_r()),
                            Spacer(),
                            Icon(Icons.navigate_next,
                                color: AppColor.primary, size: 30),
                          ],
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.launchEmail();
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 18),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          border: Border(
                            bottom: BorderSide(
                              color: AppColor.black20,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text('문의하기', style: AppTextStyle.body2_r()),
                            Spacer(),
                            Icon(Icons.navigate_next,
                                color: AppColor.primary, size: 30),
                          ],
                        )),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45, vertical: 20),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          backgroundColor: AppColor.primary,
                        ),
                        onPressed: () {
                          Get.dialog(
                            CustomDialog(
                              leftButtonText: '취소',
                              rightButtonText: '확인',
                              leftButtonOnTap: () {
                                Get.back();
                              },
                              rightButtonOnTap: () {
                                Get.find<AuthController>().logout();
                                Get.back();
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('정말 로그아웃하시겠습니까?'),
                                    ],
                                  )
                              ),
                            )
                          );
                        },
                        child: Text('로그아웃'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
