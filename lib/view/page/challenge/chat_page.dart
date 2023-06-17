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
    return WillPopScope(
      onWillPop: () {
        controller.onDelete();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.white,
          foregroundColor: AppColor.black,
          elevation: 0,
          title: Text(controller.challenge.title, style: AppTextStyle.body2_m()),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => ChatDetailPage(
                    challenge: controller.challenge,
                    members: controller.memberList));
              },
              icon: const Icon(Icons.info_outline),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          color: AppColor.black10,
          child: Column(
            children: <Widget>[
              Obx(() => Expanded(
                    child: ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.chats.length,
                      itemBuilder: (context, index) {
                        Message chat = controller.chats[index];
                        final currentChatDate = chat.time.toDate();
                        final currentSender = chat.sender!.uid;
                        final minutes = currentChatDate.minute + currentChatDate.hour * 60;

                        bool cutMinutes = (
                          index == 0 ||
                          minutes != controller.chats[index - 1].time.toDate().minute + controller.chats[index - 1].time.toDate().hour * 60
                        );

                        bool showUserName = (
                          index == 0 ||
                          currentSender != controller.chats[index - 1].sender!.uid ||
                          cutMinutes
                        );
                        bool showTime = false;

                        if (index == controller.chats.length - 1) {
                          showTime = true;
                        } else {
                          final nextChat = controller.chats[index + 1];
                          final nextChatDate = nextChat.time.toDate();
                          final nextSender = nextChat.sender!.uid;
                          final nextMinutes =
                              nextChatDate.minute + nextChatDate.hour * 60;

                          if (minutes != nextMinutes ||
                              currentSender != nextSender) {
                            showTime = true;
                          }
                        }

                        return Column(
                          children: [
                            if (index == 0 ||
                                currentChatDate.year !=
                                    controller.chats[index - 1].time
                                        .toDate()
                                        .year ||
                                currentChatDate.month !=
                                    controller.chats[index - 1].time
                                        .toDate()
                                        .month ||
                                currentChatDate.day !=
                                    controller.chats[index - 1].time
                                        .toDate()
                                        .day)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 6),
                                  decoration: BoxDecoration(
                                      color: AppColor.black40,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(
                                    '${currentChatDate.year}.${currentChatDate.month}.${currentChatDate.day}',
                                    style: AppTextStyle.body4_r(
                                        color: AppColor.white),
                                  ),
                                ),
                              ),
                            MessageTile(
                              message: chat,
                              sentByMe: controller.user.uid == chat.sender!.uid,
                              showUserName: showUserName,
                              showTime: showTime,
                            ),
                          ],
                        );
                      },
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
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
                          controller
                              .sendMessage(controller.challenge.challengeId!);
                        },
                      )),
                      TextButton(
                        child: Text('전송',
                            style:
                                AppTextStyle.body2_m(color: AppColor.primary)),
                        onPressed: () {
                          controller
                              .sendMessage(controller.challenge.challengeId!);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
