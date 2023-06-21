import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/challenge/chat_controller.dart';
import '../../../model/challenge.dart';
import '../../../model/user_model.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';
import '../../widget/custom_dialog.dart';
import '../friends/friend_detail_page.dart';

class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage(
      {Key? key, required this.challenge, required this.members})
      : super(key: key);
  final Challenge challenge;
  final RxList<UserModel> members;

  @override
  Widget build(BuildContext context) {
    var chatController = Get.find<ChatController>();

    RxList<UserModel> nextAdminList = RxList.from(members);
    nextAdminList.removeWhere((member) => member.uid == challenge.admin.uid);
    Rx<UserModel> selectedAdmin = Rx<UserModel>(nextAdminList[0]);

    return Scaffold(
      backgroundColor: AppColor.black10,
      appBar: AppBar(
        title: Text('챌린지 정보', style: AppTextStyle.body2_r()),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                challenge.admin.uid != FirebaseAuth.instance.currentUser!.uid || members.length < 2
                ? Get.dialog(
                  CustomDialog(
                    leftButtonText: '취소',
                    rightButtonText: '나가기',
                    leftButtonOnTap: () {
                      Get.back();
                    },
                    rightButtonOnTap: () {
                      chatController.exitChallenge(challenge.challengeId!);
                      Get.back();
                      Get.snackbar('${challenge.title}', '탈주 완');
                    },
                    child: Container(
                        padding: const EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('${challenge.title} 챌린지를\n포기하시겠습니까?'),
                        ],
                      )
                    ),
                  )
                )
                : Get.dialog(
                    CustomDialog(
                      leftButtonText: '취소',
                      rightButtonText: '나가기',
                      leftButtonOnTap: () {
                        Get.back();
                      },
                      rightButtonOnTap: () {
                        chatController.exitAdmin(challenge.challengeId!, selectedAdmin.value.uid);
                        Get.back();
                        Get.snackbar('${challenge.title}', '탈주 완');
                      },
                      child: Container(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text('다음 관리자를 선택하세요'),
                                  Obx(
                                    () => DropdownButton(
                                      value: selectedAdmin.value.uid,
                                      items: nextAdminList
                                          .map((member) => DropdownMenuItem(
                                          value: member.uid,
                                          child: Text('${member.name}')
                                      ))
                                          .toList(),
                                      onChanged: (value) {
                                        selectedAdmin.value =
                                            nextAdminList.firstWhere(
                                                  (member) => member.uid == value,
                                            );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                      ),
                    )
                );
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: AppColor.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${challenge.plant}',
                    style: AppTextStyle.body4_r(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  '${challenge.title}',
                  style: AppTextStyle.body1_b(color: AppColor.black80),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16),
                    SizedBox(width: 4),
                    Text(
                        '챌린지 기간 : ${DateFormat("yyyy-MM-dd").format(challenge.startDate.toDate())} ~ ${DateFormat("yyyy-MM-dd").format(challenge.endDate.toDate())}',
                        style: AppTextStyle.body4_r(color: AppColor.black40)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(challenge.content),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: Row(
              children: [
                Text(
                  '참가자 ',
                  style: AppTextStyle.body2_b(color: AppColor.black80),
                ),
                Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.only(left: 2),
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Center(
                    child: Text(
                      '${challenge.members!.length}',
                      style: AppTextStyle.body4_r(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(
                () => ListView.builder(
                    itemCount: members.length,
                    itemBuilder: (context, index) {
                      UserModel member = members[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          onTap: (){
                            Get.to(() => FriendDetailPage(), arguments: [member]);
                          },
                          tileColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColor.black50,
                            backgroundImage: member.profileImg != null
                                ? NetworkImage(member.profileImg!)
                                : null,
                            child: member.profileImg != null
                                ? null
                                : Icon(Icons.person, color: AppColor.white),
                          ),
                          title: Row(
                            children: [
                              Text(
                                '${member.name}',
                                style: AppTextStyle.body2_m(),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              challenge.admin.uid == member.uid
                                  ? CircleAvatar(
                                      radius: 8,
                                      backgroundColor: AppColor.primary,
                                      child: Image.asset(
                                        'assets/images/crown.png',
                                        width: 12,
                                      ),
                                    )
                                  : SizedBox.shrink()
                            ],
                          ),
                          subtitle: Text(
                            '${member.email}',
                            style: AppTextStyle.body3_r(color: AppColor.black60),
                          ),
                          trailing:

                          challenge.admin.uid == FirebaseAuth.instance.currentUser!.uid && challenge.admin.uid != member.uid
                          ? IconButton(
                            onPressed: (){
                              Get.dialog(
                                  CustomDialog(
                                    leftButtonText: '취소',
                                    rightButtonText: '확인',
                                    leftButtonOnTap: () {
                                      Get.back();
                                    },
                                    rightButtonOnTap: () {
                                      chatController.removeMember(challenge.challengeId!, member.uid);
                                      members.removeWhere((user) => user.uid == member.uid);
                                      Get.back();
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(30.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text('${member.name} 을 내보내시겠습니까?'),
                                          ],
                                        )
                                    ),
                                  )
                              );
                            },
                            icon: Icon(Icons.exit_to_app),
                          ): null,
                        ),
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
