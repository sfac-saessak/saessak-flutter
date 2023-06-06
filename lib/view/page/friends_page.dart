
import 'package:flutter/material.dart';

import '../../util/app_color.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('친구 관리'),
        centerTitle: true,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
      ),
    );
  }
}

