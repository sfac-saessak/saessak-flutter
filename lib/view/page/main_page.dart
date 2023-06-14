import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/main_controller.dart';
import '../../util/app_color.dart';
import '../../util/app_routes.dart';
import '../../util/app_text_style.dart';
import 'challenge/search_challenge_page.dart';
import 'friends/friends_page.dart';

class MainPage extends GetView<MainController> {
  const MainPage({Key? key}) : super(key: key);
  static const String route = '/main';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () {
            if (controller.curPage == 0) {
              return Text("식물 관리", style: AppTextStyle.body2_m());
            } else if (controller.curPage == 1) {
              return Text("관리", style: AppTextStyle.body2_m());
            } else if (controller.curPage == 2) {
              return Text("게시판", style: AppTextStyle.body2_m());
            } else if (controller.curPage == 3) {
              return Text("챌린지", style: AppTextStyle.body2_m());
            } else if (controller.curPage == 4) {
              return Text("설정", style: AppTextStyle.body2_m());
            } else {
              return Text('');
            }
          },
        ),
        centerTitle: true,
        automaticallyImplyLeading: false, // 자동 뒤로가기 버튼 생성 비활성화
        backgroundColor: Colors.white,
        foregroundColor: AppColor.black,
        elevation: 0,
        actions: [
          Obx(
            () {
              if (controller.curPage == 0) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.people),
                    onPressed: () => Get.to(() => FriendsPage()),
                  ),
                );
              } else if (controller.curPage == 3) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => Get.to(() => SearchChallengePage()),
                  ),
                );
              } else if (controller.curPage == 4) {
                return IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.setName);
                  },
                  icon: Icon(Icons.edit),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
      body: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          itemCount: controller.screens.length,
          itemBuilder: (context, index) {
            return Obx(() => controller.screens[controller.curPage]);
          }),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.green,
              onTap: controller.onPageTapped,
              currentIndex: controller.curPage,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: Opacity(
                      opacity: 0.4,
                      child: Image.asset('assets/images/home.png')),
                  label: '홈',
                  activeIcon: Image.asset('assets/images/home.png'),
                ),
                BottomNavigationBarItem(
                    icon: Opacity(
                        opacity: 0.4,
                        child: Image.asset('assets/images/schedule.png')),
                    label: '일정일지',
                    activeIcon: Image.asset('assets/images/schedule.png')),
                BottomNavigationBarItem(
                    icon: Opacity(
                        opacity: 0.4,
                        child: Image.asset('assets/images/community.png')),
                    label: '게시판',
                    activeIcon: Image.asset('assets/images/community.png')),
                BottomNavigationBarItem(
                    icon: Opacity(
                        opacity: 0.4,
                        child: Image.asset('assets/images/challenge.png')),
                    label: '챌린지',
                    activeIcon: Image.asset('assets/images/challenge.png')),
                BottomNavigationBarItem(
                    icon: Opacity(
                        opacity: 0.4,
                        child: Image.asset('assets/images/setting.png')),
                    label: '설정',
                    activeIcon: Image.asset('assets/images/setting.png')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
