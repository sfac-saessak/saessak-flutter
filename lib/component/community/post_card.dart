import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/controller/community/community_controller.dart';
import 'package:saessak_flutter/model/community/post.dart';
import 'package:saessak_flutter/util/app_color.dart';
import 'package:saessak_flutter/util/app_text_style.dart';
import 'package:saessak_flutter/view/page/community/post_detail_page.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () async {
          Get.find<CommunityController>().goPost(post);
        },
        child: SizedBox(
            height: 240,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(post.title, style: AppTextStyle.body2_m()),
                      ),
                    ],
                  ),
                  Divider(color: AppColor.primary, thickness: 1),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Text(
                              post.content,
                              maxLines: 5,
                              style: AppTextStyle.body2_r().copyWith(color: AppColor.darkGrey),
                            ),
                          ),
                          if (post.imgUrlList.isNotEmpty)
                            AspectRatio(
                              aspectRatio: 1.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  post.imgUrlList[0],
                                  fit: BoxFit.cover,                                
                                ),
                               
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(post.user != null ? post.user!.name : '작성자이름', style: AppTextStyle.body4_m(),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(Get.find<CommunityController>()
                            .convertTime(post.writeTime), style: AppTextStyle.body4_m().copyWith(color: AppColor.primary,),),
                      ),
                      Icon(Icons.remove_red_eye_outlined),
                      Text(post.views.toString()),
                      SizedBox(width: 10,),
                      Icon(Icons.message_sharp),
                      Text(post.commentsNum.toString()),
                    ],
                  )
                ]),
              ),
            )),
      ),
    );
  }
}
