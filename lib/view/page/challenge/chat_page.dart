import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/challenge/chat_controller.dart';
import '../../../model/message.dart';
import '../../../util/app_color.dart';
import '../../../util/app_text_style.dart';
import '../../widget/app_text_field.dart';
import '../../widget/message_tile.dart';
import 'chat_detail_page.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({Key? key}) : super(key: key);
  static const String route = '/chat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
        title: Text(controller.challenge.title),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => ChatDetailPage(challenge: controller.challenge, members: controller.memberList));
            },
            icon: const Icon(Icons.info_outline),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        color: AppColor.black10,
        child: Column(
          children: <Widget>[
            Obx(() => Expanded(
                  child: ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.chats.length,
                    itemBuilder: (context, index) {
                      Message chat = controller.chats[index];
                      return MessageTile(
                          message: chat,
                          sentByMe: controller.user.uid == chat.sender.uid);
                    },
                  ),
                )),
            Container(
              alignment: Alignment.bottomCenter,
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColor.primary,
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: AppTextField(
                    hintText: '채팅 입력...',
                    controller: controller.messageController,
                    onSubmitted: (p0) {
                      controller.sendMessage(controller.challenge.challengeId!);
                    },
                  )),
                  TextButton(
                    child: Text('전송',
                        style: AppTextStyle.body2_m(color: AppColor.primary)),
                    onPressed: () {
                      controller.sendMessage(controller.challenge.challengeId!);
                    },
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
