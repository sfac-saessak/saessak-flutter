import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/view/screen/schedule_journal_screen.dart';

import '../../view/screen/shcedule_journal/journal_screen.dart';
import '../../view/screen/shcedule_journal/schedule_screen.dart';

class ScheduleJornalMainController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;         // 탭바 컨트롤러


final List<Tab> tabs = <Tab>[             // 탭
    Tab(text: '일정'),
    Tab(text: '일지'),
  ];

  final List<Widget> tabViews = <Widget>[   // 탭 뷰
    ScheduleScreen(),
    JournalScreen()
  ];

@override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }

    @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }
}