import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/util/app_color.dart';
import 'package:saessak_flutter/util/app_routes.dart';

import '../../component/login/custom_button.dart';
import '../../component/login/custom_text_field.dart';
import '../../controller/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);
  static const String route = '/login';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
                    Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.fill,
                    ),
                    Image.asset(
                      'assets/images/title.png',
                      fit: BoxFit.fill,
                    ),
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
                          isObscured: controller.isObscured.value,
                          suffixIcon: IconButton(
                            onPressed: controller.changeObscure,
                            icon: Image.asset(color: AppColor.black40,controller.isObscured.value
                                ? 'assets/images/eyeoff.png'
                                : 'assets/images/eyeon.png'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    CustomButton(
                      text: '로그인',
                      onPressed: controller.login,
                      isenableButton: controller.isValidLogin.value,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: controller.resetPassWord,
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
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                          color: AppColor.darkGrey,
                        )),
                        Text(
                          '      SNS 계정으로 로그인      ',
                          style: TextStyle(color: AppColor.darkGrey),
                        ),
                        Expanded(
                            child: Divider(
                          color: AppColor.darkGrey,
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: controller.signInWithGoogle,
                      child: Stack(children: [
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColor.lightGrey,
                            ),
                          ),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Google로 로그인',
                              textAlign: TextAlign.center,
                            ),
                          )),
                        ),
                        Positioned(
                            child: Image.asset('assets/images/google_logo.png',
                                width: 30),
                            bottom: 15,
                            left: 15),
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
