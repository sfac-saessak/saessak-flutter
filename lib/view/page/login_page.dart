import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/util/app_color.dart';

import '../../component/login/custom_button.dart';
import '../../component/login/custom_text_field.dart';
import '../../controller/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);
  static const String route = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png'),
                  Image.asset('assets/images/title.png'),
                  SizedBox(height: 50),
                  Column(
                    children: [
                      CustomTextField(
                        controller: controller.emailController,
                        onChanged: controller.onChanged,
                        hintText: '이메일주소',
                        errorText: controller.emailErrorText.value ?? null,
                      ),
                      SizedBox(height: 16.0),
                      CustomTextField(
                        controller: controller.pwController,
                        onChanged: controller.onChanged,
                        hintText: '비밀번호',
                        errorText: controller.pwErrorText.value ?? null,
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: AppColor.grey,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  CustomButton(
                    text: '로그인',
                    onPressed: controller.login,
                    isValidLogin: controller.isValidLogin.value,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: controller.signup,
                          child: Text(
                            '비밀번호찾기',
                            style: TextStyle(color: AppColor.black),
                          )),
                      TextButton(
                          onPressed: controller.signup,
                          child: Text(
                            '회원가입',
                            style: TextStyle(color: AppColor.black),
                          )),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                      )),
                      Text('    SNS 계정으로 로그인    '),
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: controller.signInWithGoogle,
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColor.lightGrey,
                        ),
                      ),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.google),
                          SizedBox(width: 8),
                          Text('Sign in with Google'),
                        ],
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
