import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/controller/community/community_controller.dart';
import 'package:saessak_flutter/model/community/post.dart';
import 'package:saessak_flutter/util/app_color.dart';
import 'package:saessak_flutter/util/app_text_style.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {

    

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: GestureDetector(
        onTap: () async {
          Get.find<CommunityController>().goPost(post);
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(children: [
            Row(
              children: [
                Container(
                    width: 30,
                    height: 30,
                    child: post.user!.profileImg != null
                        ? Image.network(
                            post.user!.profileImg!,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return CircleAvatar(
                                    radius: 25,
                                    backgroundColor: AppColor.black10,
                                    backgroundImage:
                                        NetworkImage(post.user!.profileImg!));
                              }
                              return CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 25,
                                child: CircularProgressIndicator(
                                  color: AppColor.primary,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          )
                        : CircleAvatar(
                            radius: 25,
                            backgroundColor: AppColor.black10,
                            backgroundImage:
                                AssetImage('assets/images/logo.png'))),
                SizedBox(width: 5),
                Text(post.user != null ? post.user!.name : '작성자이름',
                    style: AppTextStyle.body4_r()),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.title,
                          style: AppTextStyle.body3_m(),
                          overflow: TextOverflow.ellipsis),
                      SizedBox(height: 5),
                      Text(post.content,
                          maxLines: 5,
                          style: AppTextStyle.body4_r()
                              .copyWith(color: AppColor.darkGrey),
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                if (post.imgUrlList.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 24, bottom: 10),
                    child: Container(
                      width: 76,
                      height: 76,
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            post.imgUrlList[0],
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 76,
                                child: CircularProgressIndicator(
                                  color: AppColor.primary,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (post.imgUrlList.isEmpty) SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.remove_red_eye_outlined,
                    color: AppColor.black40, size: 14),
                SizedBox(width: 3),
                Text(post.views.toString(),
                    style: AppTextStyle.body5_r(color: AppColor.black40)),
                SizedBox(width: 10),
                Icon(Icons.chat_outlined, color: AppColor.black40, size: 14),
                SizedBox(width: 3),
                Text(post.commentsNum.toString(),
                    style: AppTextStyle.body5_r(color: AppColor.black40)),
                Spacer(),
                Text(
                    Get.find<CommunityController>().convertTime(post.writeTime),
                    style: AppTextStyle.body5_r(color: AppColor.black40)),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
