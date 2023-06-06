import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/message.dart';
import '../../util/app_color.dart';
import '../../util/app_text_style.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({Key? key, required this.message, required this.sentByMe})
      : super(key: key);
  final Message message;
  final bool sentByMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sentByMe
                ? Container()
                : CircleAvatar(
                    backgroundColor: AppColor.grey,
                    backgroundImage: message.sender.profileImg != null ? NetworkImage(message.sender.profileImg!) : null,
                    child: message.sender.profileImg != null ? null : Icon(Icons.person, color: AppColor.white),
                  ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sentByMe
                      ? Container()
                      : Text(message.sender.name, style: AppTextStyle.body3_m()),
                  sentByMe ? Container() : SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      sentByMe
                          ? Text(
                              '${DateFormat('HH:mm').format(message.time.toDate())}',
                              style: AppTextStyle.caption_r())
                          : Container(),
                      sentByMe ? SizedBox(width: 4) : Container(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
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
                            color:
                                sentByMe ? AppColor.primary : AppColor.white),
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
                      sentByMe ? Container() : SizedBox(width: 4),
                      sentByMe
                          ? Container()
                          : Text(
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
