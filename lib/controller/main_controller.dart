import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/screen/community_screen.dart';
import '../view/screen/home_screen.dart';
import '../view/screen/schedule_journal_screen.dart';
import '../view/screen/setting_screen.dart';
import '../view/screen/challenge/challenge_screen.dart';

class MainController extends GetxController {
  var pageController = PageController();
  RxInt _curPage = 0.obs;
  int get curPage => _curPage.value;

  List<Widget> screens = [
    HomeScreen(),
    ScheduleJournalScreen(),
    CommunityScreen(),
    ChallengeScreen(),
    SettingScreen(),
  ];

  onPageTapped(int v) {
    _curPage(v);
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
    _curPage(0);
  }
}
