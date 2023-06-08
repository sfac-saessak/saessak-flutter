
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/controller/follow/friends_controller.dart';

import '../../model/user_model.dart';
import '../../service/db_service.dart';

class FriendTile extends StatelessWidget {
  const FriendTile({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<FriendsController>();
    return ListTile(
      leading: CircleAvatar(
        radius: 36,
        backgroundColor: Colors.grey,
        child: user.profileImg == null ? Icon(Icons.person, color: Colors.white) : null,
        backgroundImage: user.profileImg != null
            ? NetworkImage(user.profileImg!)
            : null,
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 80,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 0
          ),
          onPressed: () async {
            await DBService(uid: FirebaseAuth.instance.currentUser!.uid).toggleUserFollow(user.uid);
          },
          child: Text('팔로우'),
        ),
      ),
    );
  }
}
