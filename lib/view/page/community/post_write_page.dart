import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saessak_flutter/controller/community/community_controller.dart';

import '../../../model/community/post.dart';

class PostWritePage extends GetView<CommunityController> {
  PostWritePage({super.key, this.post});

  final Post? post; 

  @override
  Widget build(BuildContext context) {
   if(post != null){
    controller.titleController.text = post!.title;
    controller.contentController.text = post!.content;
    controller.imgDownloadUrlList = post!.imgUrlList;
   }
   if(post == null){
    controller.imgDownloadUrlList = [];
   }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        centerTitle: false,
        title: post == null ? Text('게시글 작성') : Text('게시글 수정'),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), onPressed: ()async {
          await controller.getPosts();
          Get.back();
        },),
        actions: [
          TextButton(
              onPressed: () {
                //작성글 DB에 저장
               controller.writePost();
              },
              child: Text(
                '작성 완료',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(DateTime.now().toString()),
            Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Obx(
                    () => DropdownButton(
                      items: [
                        DropdownMenuItem(child: Text('정보'), value: '정보'),
                        DropdownMenuItem(child: Text('질문'), value: '질문'),
                        DropdownMenuItem(child: Text('잡담'), value: '잡담')
                      ],
                      onChanged: (String? value) {
                        controller.dropDownVal.value = value!;
                      },
                      value: controller.dropDownVal.value,
                    ),
                  ),
                  TextField(
                    controller: controller.titleController,

                    maxLines: 2,
                    decoration: InputDecoration(hintText: '제목'),
                  ),
                  Divider(),
                  TextField(
                    controller: controller.contentController,
                    maxLines: 22,
                    decoration: InputDecoration(hintText: '내용'),
                  ),

                  // 이하 사진 등록부
                  Obx(
                    () => SizedBox(
                      height: Get.height * 0.12,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children:
                        
                        
                         [
                          //post에서 받아온 imgUrlList로 만든 컨테이너들 추가 -> 만약 글 작성시 or 사진첨부 없는 글 수정시 그냥 없는거임(리스트 기본값 []로 되어있으므로).
                          ...controller.imgDownloadUrlList.map((e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                child: Container(
                                  child: Image.network(
                                    e,
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.grey,
                                  height: Get.height * 0.1,
                                  width: Get.height * 0.1,
                                ),
                                onTap: () {
                                  controller.imgDownloadUrlList.remove(e); // 추가한 사진 삭제
                                  print(controller.imgDownloadUrlList);
                                },
                              ),
                            )).toList(),




                          ///
                          ...controller.imgXfileList.map((e) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                child: Container(
                                  child: Image.asset(
                                    e.path,
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.grey,
                                  height: Get.height * 0.1,
                                  width: Get.height * 0.1,
                                ),
                                onTap: () {
                                  controller.imgXfileList.remove(e); // 추가한 사진 삭제
                                },
                              ),
                            );
                          }).toList(),
                          GestureDetector(
                            // 선택한 사진을 동일 사이즈로 버튼 우측에 보이도록 추가.
                            onTap: () async {
                              try {
                                XFile? image = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (image != null) {
                                  controller.imgXfileList.add(image);
                                  print(
                                      'controller.imgXfileList: ${controller.imgXfileList}');
                                  print(
                                      'controller List: ${controller.imgXfileList}');
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Icon(Icons.add),
                                color: Colors.grey,
                                height: Get.height * 0.1,
                                width: Get.height * 0.1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
