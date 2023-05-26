import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saessak_flutter/controller/community/community_controller.dart';

class PostWritePage extends GetView<CommunityController> {
  PostWritePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController();
    controller.imgPathList.value = [''];

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        centerTitle: false,
        title: Text('게시글 작성'),
        actions: [
          TextButton(
              onPressed: () {
                //작성글 DB에 저장
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
                    controller: _textController,
                    maxLines: 22,
                  ),
                  Obx(
                    () => SizedBox(
                      height: Get.height * 0.12,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: controller.imgPathList.map((e) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Container(
                                /// 여기 하던중
                                child: e == ''
                                    ? Icon(Icons.add)
                                    : Image.asset(
                                        e,
                                        fit: BoxFit.cover,
                                      ),
                                color: Colors.grey,
                                height: Get.height * 0.1,
                                width: Get.height * 0.1,
                              ),

                              // 선택한 사진을 동일 사이즈로 버튼 우측에 보이도록 추가.
                              onTap: () async {
                                try {
                                  XFile? image = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  if (image != null) {
                                    print(image); //test
                                    controller.imgPathList.add(image.path);
                                    print(controller.imgPathList); //test
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              },
                              onLongPress: () {
                                //controller.imgPathList.value.removeAt(index);
                              },
                            ),
                          );
                        }).toList(),
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
