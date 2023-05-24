
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../service/auth_service.dart';
import '../util/app_routes.dart';

class SetProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  User? get user => FirebaseAuth.instance.currentUser;
  Rxn<File> selectedImage = Rxn();

  addProfilePhoto() async {
    var picker = ImagePicker();
    var res = await picker.pickImage(source: ImageSource.gallery);
    if (res != null) {
      selectedImage(File(res.path));
    }
  }

  onTapStartBtn() async {
    if (selectedImage.value != null) {
      var ref = FirebaseStorage.instance.ref('profile/${user!.uid}');
      await ref.putFile(selectedImage.value!);
      var downloadUrl = await ref.getDownloadURL();
      print(downloadUrl);
      user!.updatePhotoURL(downloadUrl);
    }

    await user!.updateDisplayName(nameController.text);
    await AuthService().saveUserInfoToFirestore(user!);
    Get.offAllNamed(AppRoutes.main);
  }

  @override
  void onInit() {
    super.onInit();
    nameController.text = user!.displayName ?? '';
  }
}
