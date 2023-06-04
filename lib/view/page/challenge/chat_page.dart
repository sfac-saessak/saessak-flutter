
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/challenge/chat_controller.dart';
import '../../../model/message.dart';
import '../../../util/app_color.dart';
import '../../widget/message_tile.dart';

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

            },
            icon: const Icon(Icons.info_outline),
          )
        ],
      ),
      body: Container(
        color: AppColor.lightGrey,
        child: Column(
          children: <Widget>[
            // chat messages here
            Obx(
              () => Expanded(
                child: ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.chats.length,
                  itemBuilder: (context, index) {
                    Message chat = controller.chats[index];
                    return MessageTile(message: chat, sentByMe: controller.user.displayName == chat.sender);
                  },
                ),
              )
            ),
            Container(
              alignment: Alignment.bottomCenter,
              width: Get.width,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                width: Get.width,
                color: Colors.grey[700],
                child: Row(children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Send a message...",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.sendMessage(controller.challenge.challengeId!);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
