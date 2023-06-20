import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/message.dart';
import '../../util/app_color.dart';
import '../../util/app_text_style.dart';
import '../page/friends/friend_detail_page.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({Key? key, required this.message, required this.sentByMe, required this.showUserName, required this.showTime})
      : super(key: key);
  final Message message;
  final bool sentByMe;
  final bool showUserName;
  final bool showTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!sentByMe && showUserName) SizedBox(height: 8),
          Row(
            mainAxisAlignment: sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!sentByMe && showUserName)
                GestureDetector(
                  onTap: (){
                    Get.to(() => FriendDetailPage(), arguments: [message.sender]);
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColor.black20,
                    backgroundImage: message.sender!.profileImg != null
                      ? NetworkImage(message.sender!.profileImg!)
                      : null,
                    child: message.sender!.profileImg != null
                      ? null
                      : Icon(Icons.person, color: AppColor.white),
                  ),
                ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!sentByMe && showUserName)
                    Text(message.sender!.name, style: AppTextStyle.body3_m()),
                  if (!sentByMe && showUserName) SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (sentByMe && showTime)
                        Text(
                          '${DateFormat('HH:mm').format(message.time.toDate())}',
                          style: AppTextStyle.caption_r(),
                        ),
                      if (sentByMe) SizedBox(width: 4),
                      if (!sentByMe && !showUserName) SizedBox(width: 40),
                      Container(
                        padding: const EdgeInsets.symmetric( horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: sentByMe
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              )
                            : const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                          color: sentByMe ? AppColor.primary : AppColor.white
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints: BoxConstraints(maxWidth: 200),
                              child: Text(
                                message.message,
                                style: AppTextStyle.body3_r(
                                  color: sentByMe
                                    ? AppColor.white
                                    : AppColor.black),
                              ),
                            )
                          ],
                        ),
                      ),
                      if (!sentByMe) SizedBox(width: 4),
                      if (!sentByMe && showTime)
                        Text(
                          '${DateFormat('HH:mm').format(message.time.toDate())}',
                          style: AppTextStyle.caption_r()),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
