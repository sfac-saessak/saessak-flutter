import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/component/login/custom_button.dart';
import 'package:saessak_flutter/component/login/custom_text_field.dart';

import '../../controller/signup_controller.dart';
import '../../util/app_color.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({Key? key}) : super(key: key);
  static const String route = '/signup';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
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
                    CustomTextField(
                      controller: controller.emailController,
                      hintText: '이메일',
                      errorText: controller.emailErrorText.value,
                      onChanged: controller.emailOnChanged,
                    ),
                    SizedBox(height: 16.0),
                    CustomTextField(
                      isObscured: controller.isObscured.value,
                          suffixIcon: IconButton(
                            onPressed: controller.changeObscure,
                            icon: Image.asset(color: AppColor.black40,controller.isObscured.value
                                ? '/Users/anjongjun/VScodeProjects/team_project/saessak-flutter/assets/images/eyeoff.png'
                                : '/Users/anjongjun/VScodeProjects/team_project/saessak-flutter/assets/images/eyeon.png'),
                          ),
                      controller: controller.pwController,
                      hintText: '비밀번호',
                      errorText: controller.pwErrorText.value,
                      onChanged: () {
                        controller.pwOnChanged();
                        controller.pwConfirmOnChanged();
                      },
                    ),
                    SizedBox(height: 16.0),
                    CustomTextField(
                      isObscured: controller.isObscured.value,
                          suffixIcon: IconButton(
                            onPressed: controller.changeObscure,
                            icon: Image.asset(color: AppColor.black40,controller.isObscured.value
                                ? '/Users/anjongjun/VScodeProjects/team_project/saessak-flutter/assets/images/eyeoff.png'
                                : '/Users/anjongjun/VScodeProjects/team_project/saessak-flutter/assets/images/eyeon.png'),
                          ),
                      controller: controller.pwConfirmController,
                      hintText: '비밀번호 확인',
                      errorText: controller.pwConfirmErrorText.value,
                      onChanged: () {
                        controller.pwOnChanged();
                        controller.pwConfirmOnChanged();
                      },
                    ),
                    SizedBox(height: 36.0),
                    CustomButton(
                        onPressed: controller.signUp,
                        text: '회원가입',
                        isenableButton: controller.isValidSignUp.value)
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
