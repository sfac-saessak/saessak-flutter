
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/setting_controller.dart';
import '../../util/app_color.dart';
import '../../util/app_text_style.dart';

class NoticePage extends GetView<SettingController> {
  const NoticePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('공지사항', style: AppTextStyle.body2_m()),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: controller.noticeList.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text('${controller.noticeList[index].title}'),
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${DateFormat("yyyy-MM-dd").format(controller.noticeList[index].writeTime.toDate())}'),
                    SizedBox(height: 8),
                    Text('${controller.noticeList[index].content}'),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
