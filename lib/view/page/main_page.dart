
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/main_controller.dart';

class MainPage extends GetView<MainController> {
  const MainPage({Key? key}) : super(key: key);
  static const String route = '/main';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,   // 자동 뒤로가기 버튼 생성 비활성화
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        itemCount: controller.screens.length,
        itemBuilder: (context, index) {
          return controller.screens[index];
        }
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green,
          onTap: controller.onPageTapped,
          currentIndex: controller.curPage.value,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: '일정일지'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: '게시판'),
            BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: '챌린지'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
          ],
        ),
      ),
    );
  }
}
